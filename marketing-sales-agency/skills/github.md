# GitHub Asset Store

Use this skill to read from or write to the shared agency GitHub repository.
All credentials are available as environment variables: $GITHUB_TOKEN and $GITHUB_REPO.

## Read a file

```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FILE_PATH" \
  | python3 -c "import sys,json,base64; d=json.load(sys.stdin); print(base64.b64decode(d['content']).decode())"
```

## Write or update a file

```bash
# Step 1: Get current SHA (required for updates, empty string for new files)
SHA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FILE_PATH" \
  | python3 -c "import sys,json; print(json.load(sys.stdin).get('sha',''))" 2>/dev/null || echo "")

# Step 2: Base64-encode your content
CONTENT=$(printf '%s' "$YOUR_CONTENT" | base64 -w 0)

# Step 3: Push
curl -s -X PUT -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FILE_PATH" \
  -d "{\"message\":\"$COMMIT_MSG\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\"}"
```

## List files in a folder

```bash
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPO/contents/$FOLDER_PATH" \
  | python3 -c "import sys,json; [print(f['name'], f['type']) for f in json.load(sys.stdin)]"
```

## Recommended repo structure

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
|   └── meta_ads/
└── reports/
    └── weekly/
```
