---
name: github
description: Read from and write to the shared agency GitHub asset repository — the source of truth for product briefs, research, content drafts, campaigns, and reports that every agent contributes to and pulls from. Use whenever the user mentions "save to the asset repo," "pull the product doc from GitHub," "put this in the shared repo," "update the research folder," "commit this to the agency repo," "check GitHub for the latest brief," "store the draft in GitHub," "push to conseal-agency-assets," or any variant of reading/writing files in the team's GitHub store. Also trigger when an agent needs to fetch context that lives in the asset repo (product-marketing brief, competitive landscape, prior week's report) before starting a task, or needs to hand off a deliverable to another agent via the repo. Works with any file path under the repo — product/, research/, content/blog-posts/, content/linkedin/, content/x/, content/reddit/, campaigns/outbound-sequences/, campaigns/google_ads/, campaigns/meta_ads/, reports/weekly/. Covers read, write/update, and list-folder operations via the GitHub Contents API.
metadata:
  version: 1.0.0
---

# GitHub Asset Store

The agency uses a single GitHub repository as the shared filesystem between agents. The CMO drops a brief there, the Research Analyst adds the competitive landscape, the Content Strategist writes a blog post into `content/blog-posts/`, and the SDR reads it all to build outbound. Nothing is tribal knowledge — if it matters, it lives in the repo.

This skill gives you three primitives: read a file, write/update a file, and list a folder. Everything else composes from these.

## Credentials

Two environment variables are pre-set by Paperclip from the `secrets:` block in `.paperclip.yaml`:

- `$GITHUB_TOKEN` — Personal Access Token with `Contents: read/write` scope on the asset repo
- `$GITHUB_REPO` — Fully qualified repo in the form `owner/name` (e.g. `Sri-Krishna-V/conseal-agency-assets`)

Never echo `$GITHUB_TOKEN` into logs, commit messages, file contents, or reports. If you need to debug auth, redact it.

## Read a file

Use this before you start a task that depends on shared context. Typical pattern: the CEO asks the CMO to plan a campaign, the CMO first reads `product/conseal-product-doc.md` to ground the plan in the actual positioning.

```bash
FILE_PATH="product/conseal-product-doc.md"

curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FILE_PATH" \
  | python3 -c "import sys,json,base64; d=json.load(sys.stdin); print(base64.b64decode(d['content']).decode())"
```

If the file doesn't exist, GitHub returns a JSON object with a `message` field — the base64 decode will fail. Check the raw response first if you're unsure whether a path exists.

## Write or update a file

Use this to publish a deliverable. The Content Strategist finishes a LinkedIn post and writes it to `content/linkedin/2026-04-24-founder-story.md`. The Research Analyst writes the weekly competitor scan to `research/competitive-landscape.md`, updating an existing file.

```bash
FILE_PATH="content/linkedin/2026-04-24-founder-story.md"
COMMIT_MSG="content: LinkedIn founder-story post draft"
YOUR_CONTENT="$(cat <<'EOF'
# Founder story post
...your markdown body here...
EOF
)"

# Step 1: Get the current SHA. Updates require it; for new files an empty string works.
SHA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FILE_PATH" \
  | python3 -c "import sys,json; print(json.load(sys.stdin).get('sha',''))" 2>/dev/null || echo "")

# Step 2: Base64-encode the content (GitHub's Contents API requires this).
CONTENT=$(printf '%s' "$YOUR_CONTENT" | base64 -w 0)

# Step 3: PUT the file.
curl -s -X PUT -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FILE_PATH" \
  -d "{\"message\":\"$COMMIT_MSG\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\"}"
```

Write a descriptive commit message — other agents read the commit log to figure out what's changed since their last run. Format: `<area>: <short description>` (e.g. `research: Q2 competitive scan`, `content: blog post on positioning`).

If you're creating a deeply nested path that doesn't exist yet (`campaigns/meta_ads/new-client/draft.md`), the Contents API will create all intermediate folders — no need to mkdir separately.

## List files in a folder

Use this to discover what's already been published before you start work. Before writing a new blog post, the Content Strategist lists `content/blog-posts/` to avoid duplicating a piece that already exists.

```bash
FOLDER_PATH="content/blog-posts"

curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FOLDER_PATH" \
  | python3 -c "import sys,json; [print(f['name'], f['type']) for f in json.load(sys.stdin)]"
```

## Canonical repo structure

Stick to this layout. If you need a path that doesn't fit, ask the CEO/CMO/CSO before inventing a new top-level folder — consistency across agents is what makes the repo useful.

```
conseal-agency-assets/
├── product/
│   └── conseal-product-doc.md        ← main product brief (MARAAAA-2)
├── research/
│   ├── competitive-landscape.md
│   └── market-sizing.md
├── content/
│   ├── blog-posts/
│   ├── linkedin/
│   ├── x/
│   └── reddit/
├── campaigns/
│   ├── outbound-sequences/
│   ├── google_ads/
│   └── meta_ads/
└── reports/
    └── weekly/
```

**Who writes where (by role):**

- **CEO** — reads everything; writes weekly synthesis to `reports/weekly/`
- **CMO / CSO** — read `product/` and their team's outputs; write strategy memos to `reports/weekly/`
- **Research Analyst** — writes to `research/`
- **Content Strategist** — writes drafts to `content/blog-posts/`, `content/linkedin/`, `content/x/`, `content/reddit/`
- **Community Manager** — reads `content/` to pull approved posts; writes engagement logs if needed
- **Paid Media Strategist** — writes campaign briefs to `campaigns/google_ads/` and `campaigns/meta_ads/`
- **SDR** — writes outbound sequences to `campaigns/outbound-sequences/`; reads `research/` for signals

## Error handling

Common failure modes and what to do:

- **401 Unauthorized** — `$GITHUB_TOKEN` is missing, expired, or lacks the right scope. Stop and report to the user; do not retry with a different token.
- **404 Not Found** on read — the path doesn't exist yet. If you expected it to exist, surface that to the user instead of silently creating it. If you're about to create it, proceed to the write step with an empty `SHA`.
- **409 Conflict** on write — someone else updated the file between your SHA lookup and your PUT. Re-fetch the SHA and try once more. If it conflicts again, stop and escalate — two agents may be stepping on each other.
- **422 Unprocessable Entity** — usually a bad base64 or malformed JSON body. Check the content encoding step.

## When not to use this skill

- For credentials, secrets, or PII — never put those in the repo. The asset store is not a secrets manager.
- For ephemeral scratch work — keep that in your local scratchpad. Only commit finished or near-finished work.
- For binary assets (images, PDFs) larger than a few MB — GitHub's Contents API is for text. For larger files, note the need and escalate to the CMO.
