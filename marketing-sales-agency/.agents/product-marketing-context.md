# Product Marketing Context — Conseal

This file is the single source of truth for any marketing agent (paperclip or otherwise) producing copy, campaigns, landing pages, ads, social posts, or sales collateral for Conseal. It is assembled from two sources: the `conseal-desktop` product codebase and the `conseal-website` marketing site at conseal.ai. Read it in full before generating anything. When information you need is not here, ask — do not invent.

---

## 1. Brand Snapshot

- **Product name:** Conseal (the desktop application is "Conseal Desktop"; the paid tier is "Conseal Pro")
- **Company:** Sprintfour Technologies Inc.
- **Category:** Privacy tools / document redaction / PII protection / AI enablement for regulated teams
- **Form factor:** Native desktop application (Windows + macOS), marketed and distributed through a Next.js website
- **Primary live tagline (used on the website):** Use AI on any document. Privately.
- **Website meta title:** Conseal | Remove PII Before AI sees it
- **Website description (meta):** Remove PII from documents before AI processing. 100% local. Complete privacy. Download for Windows.
- **Hero headlines (live):** "Conseal removes PII before AI sees it." / "Your files stay on your machine — always."
- **Hero label pill:** Private by design
- **Working taglines (secondary, for reuse):** Redact documents. Keep them yours. · Privacy-first redaction. On your desktop. · The redaction tool that never sees your documents.
- **One-liner:** Conseal is a desktop app that finds and redacts personally identifiable information in your documents — and does it entirely on your computer — so your team can safely use AI tools like ChatGPT, Claude, and Gemini on sensitive files.
- **Website / domain:** conseal.ai (live, SSL via AWS ACM, DNS via Cloudflare in DNS-only mode)
- **Distribution:** distribution.conseal.ai (auto-updater channel); direct download at `distribution.conseal.ai/latest`
- **Auth service:** auth-butler.conseal.ai (used by the desktop app and for website Stripe checkout)
- **Legal / contact:** <legal@conseal.ai>
- **Repositories (for reference):** `conseal-desktop` (Electron app), `conseal-website-v2` (Next.js marketing site)
- **License:** Proprietary, subscription-gated beyond a free tier

## 2. The Product in Plain Language

Conseal Desktop opens a document the user already has — PDF, Word (DOCX), plain text (TXT), ODT, or RTF — and scans it for personally identifiable information (PII). Detection combines two engines running **locally on the user's machine**:

1. An on-device **AI named-entity recognition (NER) model** (HuggingFace Transformers) that finds people, organizations, and locations from context.
2. A **regex engine** that catches structured identifiers: Social Security numbers, credit card numbers, emails, phone numbers, IP addresses, driver's licenses, passports, tax IDs, medical record numbers, health-insurance IDs, dates of birth, ages, bank accounts, routing numbers, IBANs, and region-specific identifiers (Aadhaar, PAN, GSTIN, IFSC, Indian phone numbers, state-prefixed US driver's licenses).

The user reviews detections in a sidebar, can add or remove redactions, and then "burns" them into a new output file — meaning the hidden text is permanently destroyed in the exported document, not just covered with a black rectangle. Optionally, the user can save a small companion file (`.conseal` vault) that records the mapping from labels back to the original values, so an authorized party can "unredact" later.

Two workflows, one app:

- **Redact** — scan + review + burn redactions into a clean output document.
- **Unredact** — open a redacted document and its `.conseal` vault to restore the original PII.

## 3. Why It Matters (Value Proposition)

Four things set Conseal apart. The first (AI-era framing) is the currently-live primary wedge on the marketing site; the other three are structural.

**Lets regulated teams use AI without breaking compliance.** This is the website's lead angle. Every team in legal, healthcare, finance, HR, and consulting wants to paste documents into ChatGPT, Claude, or Gemini — and compliance keeps saying no. Conseal sits between the document and the AI: it strips PII locally, hands the cleaned file to whichever AI tool the user prefers, and keeps the identifiable data on the user's machine. "You want AI. Compliance says no." is a line used verbatim on the site; Conseal is the resolution to that tension.

**Local-only processing.** Documents are opened, scanned, and burned entirely on the user's computer. No cloud upload, no third-party API call with the document contents, no copies sitting in someone else's S3 bucket. This is unusual in the PII/redaction space, where most competitors send documents to a hosted service. For regulated industries, this collapses a long list of data-handling concerns. The website uses the formulations "0 bytes uploaded" and "100% Local" for this pillar.

**Burn-not-cover redactions.** Conseal removes the underlying text, not just the pixels on top of it. Many "redacted" PDFs shared online still contain the original text as selectable, searchable, or recoverable data. Conseal's burn operation (via pdf-lib for PDF, XML manipulation for DOCX, string replacement for TXT) eliminates that class of leak.

**Reversible when you want it to be.** The `.conseal` vault format lets the author keep a private key to undo the redaction. Redacted documents can circulate widely; the mapping stays with whoever should control it. This is uncommon — most tools treat redaction as a one-way door. The website promise is "Restore originals anytime."

## 4. Target Audience (ICP)

Primary segments, in rough order of fit:

**Legal professionals.** Law firms, in-house counsel, paralegals, litigation support teams. They produce exhibits, discovery productions, and filings that must be scrubbed of privileged or sensitive information. "Black bars that leak text" is a well-known reputation hazard in this world.

**Healthcare administrators and compliance officers.** HIPAA requires protection of PHI in shared records, research, and case reviews. Hospitals, clinics, and health-tech vendors all need redaction workflows that don't route PHI through a third-party cloud.

**Financial services.** Banks, fintechs, wealth management, and insurance. SOC 2, PCI-DSS, and internal audit controls forbid sending account numbers, SSNs, or card numbers to unvetted SaaS. Local-only processing is the only option that passes procurement.

**HR and People Operations.** Resumes, offer letters, I-9s, background checks, disciplinary files. Need to share redacted versions with hiring panels, vendors, or across jurisdictions.

**Journalists and investigators.** FOIA and public-records work produces dumps full of personal data. Journalists need to publish source material without exposing uninvolved parties. Local-only matters for source protection.

**Government and public sector.** Courts, agencies, and contractors with restricted-handling requirements; often cannot use cloud tools at all.

**India-specific enterprises.** The regex patterns include Aadhaar, PAN, GSTIN, IFSC, and Indian phone formats. Conseal is unusually well-suited to Indian companies handling KYC, tax, and banking documents under DPDP Act obligations.

**Persona sketches (for copy reference):**

- *Priya, paralegal at a mid-size firm:* needs to redact 40 pages of discovery this afternoon; has been burned once by an Acrobat redaction that didn't actually remove text.
- *Marcus, clinical data manager:* shares anonymized patient records with a research collaborator monthly; his compliance officer banned every cloud redaction tool he tried.
- *Anjali, fintech operations lead in Bengaluru:* handles Aadhaar- and PAN-laden customer files daily and needs a tool her CISO will approve.

## 5. Pain Points We Solve

The live site frames the "problem" section with three named pains (section header: "You want AI. Compliance says no."). They are below, followed by the deeper pain list that expands on them.

**Website-defined problem trio (use these exact names for SEO and continuity with the live site):**

1. **Manual redaction** — "Hours spent manually blacking out names, addresses, and account numbers — document by document, line by line."
2. **Skipping AI** — "Your team avoids AI tools altogether because compliance won't approve sending sensitive documents to external services."
3. **Enterprise tools** — "Expensive, complex platforms designed for large organizations — overkill for teams that just need fast, private redaction."

**Expanded pain list (use in long-form collateral):**

- **Half-redacted PDFs that still contain the original text.** Black rectangles that can be copy-pasted around are a career-damaging leak.
- **"We can't upload these documents."** Most redaction tools require sending the file to a hosted service. Legal, medical, and financial teams cannot.
- **Manual redaction at scale.** Visually finding every SSN in a 200-page deposition is expensive and error-prone. AI + regex together catch more with less fatigue.
- **One-way redactions.** When the workflow requires both an external shareable version and an internal complete version, most tools force maintaining two documents by hand.
- **Multi-format pain.** Teams get PDFs, Word files, plain-text exports, and legacy ODT/RTF. Having one tool that handles all of them reduces the "tool for each format" sprawl.
- **Region-specific identifiers.** US-centric tools miss Aadhaar, PAN, GSTIN, IFSC, IBAN, etc. Conseal covers them natively.
- **AI adoption blocked by compliance.** Frontier LLMs are the productivity unlock of the decade for document-heavy work, and most teams can't use them on the documents that would benefit most. Conseal dissolves that blocker.

## 6. Messaging Pillars

Use these as the spine of any campaign. The live website exposes four named pillars in the "Why Conseal?" section. Those four map onto a longer strategic list used below. For consistency with the site, quote the website pillar names and stat tags verbatim when writing copy that will sit alongside the homepage.

**Website pillars (live, section "What makes Conseal different"):**

| Pillar name | Stat tag | Supporting line |
|---|---|---|
| Files, not just text | 5+ file types | Process entire documents, spreadsheets, and PDFs. |
| 100% Local | 0 bytes uploaded | Zero data leaves your machine. Complete privacy guaranteed. |
| Any AI tool | Any LLM | Works seamlessly with ChatGPT, Claude, Gemini, and more. |
| Smart detection | 94%+ accuracy | Combines pattern matching with AI for maximum accuracy. |

**Extended strategic pillars (for long-form collateral and campaigns):**

**Pillar 1 — Privacy by default.**

- Headline idea: "Your documents never leave your computer."
- Evidence: OCR (tesseract.js) and NER (@huggingface/transformers) both run in Web Workers inside the app; no document bytes are transmitted to any Sprintfour server. Only authentication and billing touch the network.

**Pillar 2 — Real redaction, not cosmetic.**

- Headline idea: "Burn it in. No hidden text left behind."
- Evidence: pdf-lib removes underlying text objects; DOCX redactions modify XML; TXT uses string replacement. Output documents contain no recoverable original PII.

**Pillar 3 — AI finds it so you don't have to.**

- Headline idea: "Let the scan do the first pass. You approve the final cut."
- Evidence: NER + regex hybrid covers 18+ canonical PII types and region-specific identifiers. Review sidebar lets the user add, remove, or edit any detection before burning.

**Pillar 4 — Reversible on your terms.**

- Headline idea: "Share redacted now. Keep the key to unredact later."
- Evidence: `.conseal` vault file stores the label-to-value mapping; only someone with the vault can restore the original text.

**Pillar 5 — One tool, every format.**

- Headline idea: "PDF, Word, text, ODT, RTF — all in one app."
- Evidence: Native handling of five common document formats; ODT and RTF are converted in-process.

**Pillar 6 — Bring your own AI.**

- Headline idea: "Use the AI your team already pays for — on documents they already can't touch."
- Evidence: Conseal's output is a clean document the user can paste, upload, or hand to any LLM of their choice (ChatGPT, Claude, Gemini, Copilot, internal models). Conseal is the pre-processing layer, not another AI tool to license.

## 7. Feature Inventory (Marketing-Facing)

Short, claim-safe descriptions usable in copy.

- **Automatic PII scanning** — on-device AI plus regex patterns flag names, addresses, emails, phone numbers, government IDs, financial data, and health identifiers in seconds.
- **Review-and-edit workflow** — every detection appears in a sidebar; the user approves, removes, or adjusts each one before anything is changed in the document.
- **Five file formats** — PDF, DOCX, TXT, ODT, RTF. Each renders in-app with accurate highlight overlays.
- **Permanent burn** — outputs are clean documents with the original sensitive text removed, not covered. pdf-lib for PDF, XML for DOCX, string replacement for TXT.
- **`.conseal` vault** — optional companion file that preserves the mapping from redaction labels back to original values for authorized unredaction.
- **Unredaction workflow** — open a redacted document with its vault to restore the original PII.
- **Local processing** — OCR (tesseract.js) and NER (HuggingFace Transformers) run in Web Workers inside the app. Documents do not leave the device.
- **Broad PII coverage** — PERSON, ORGANIZATION, LOCATION, EMAIL, PHONE_NUMBER, URL, IP_ADDRESS, CREDIT_CARD, BANK_ACCOUNT, ROUTING_NUMBER, SSN, DRIVER_LICENSE, PASSPORT_NUMBER, TAX_ID (EIN/ITIN), MEDICAL_RECORD_NUMBER, HEALTH_INSURANCE_ID, DATE_OF_BIRTH, AGE; plus IBAN, Aadhaar, PAN, GSTIN, IFSC, Indian phone numbers, US state-prefixed driver licenses.
- **Recent files** — quick access to the user's recent redaction work from the home screen.
- **Automatic updates** — electron-updater delivers new detection models and app fixes without reinstalls.
- **Single-instance enforcement** — opening a second file reuses the existing window.
- **Keyboard-first editing** — hotkeys for navigation, selection, and burn actions.

## 8. Proof Points and Claims We Can Make

Only the claims supported by the product implementation. Do not extrapolate.

- ✅ "Documents are processed locally on your device." True — OCR and NER run in-process in the renderer. Document bytes are not transmitted to any Sprintfour server.
- ✅ "Redactions are burned into the output; the original text is removed, not covered." True — via pdf-lib for PDF, XML manipulation for DOCX, string replacement for TXT.
- ✅ "Supports PDF, DOCX, TXT, ODT, and RTF." True.
- ✅ "Detects 18+ types of personally identifiable information, including US and Indian identifiers." True, based on the canonical entity types and regex patterns shipped.
- ✅ "Cancel anytime." True — Stripe-backed subscription with a customer billing portal.
- ✅ "Works on Windows and macOS." True — NSIS installer for Windows x64, DMG/ZIP for macOS arm64.
- ⚠️ Do not claim certification compliance (HIPAA, SOC 2, GDPR, DPDP) as "certified." Conseal's architecture supports regulated workflows, but we have not represented it as certified. Say: "built for teams with strict data-handling requirements" or "designed so your documents never leave your device."
- ⚠️ Do not claim 100% detection accuracy. Say: "Every detection is reviewable before anything is changed in your document." The license itself acknowledges that final responsibility rests with the user.
- ⚠️ "94%+ accuracy" appears on the live website pillar card ("Smart detection"). Treat this as a marketing-sourced number and confirm methodology with engineering before using it in paid media, RFP responses, or any evidentiary setting. Acceptable reuse on web / social that mirrors the site; not acceptable as a hard technical claim without a test-corpus citation.
- ⚠️ "5+ file types" (website pillar tag) and the pricing-feature list ("PDF, DOCX, RTF, TXT, ODT" — exactly five) are close but not identical. Do not promise a sixth unnamed format. The "5+" phrasing is OK because five formats qualify as "5+," but the "spreadsheets" example in the supporting line ("Process entire documents, spreadsheets, and PDFs") is not currently a shipped format — flag that to engineering.

## 9. Pricing and Distribution

- **Free tier:** 3 operations per day. An "operation" is a redact or unredact action. Enough for trial and occasional use.
- **Conseal Pro Monthly:** $12.99 / month. Billed monthly. Website badge on the card: "Most flexible." Website CTA copy: "Upgrade to Pro."
- **Conseal Pro Yearly:** $9.99 / month, billed as $119.88 / year. Website badge on the card: "Save 23%." In-app UI calls this "Best value." Website CTA copy: "Upgrade to Pro."
- **What's included on the pricing page (live feature list):** Automatic PII redaction · Restore originals anytime · Unlimited operations · 100% offline · PDF, DOCX, RTF, TXT, ODT.
- **Pricing page headline (live):** "Redact. Process locally. Restore anytime."
- **Pricing page subheadline (live):** "100% local processing means your sensitive data never leaves your device."
- **Billing:** Stripe. Customer portal accessible in-app for subscription management, invoices, and cancellation. The website calls the checkout endpoint through auth-butler (`auth-butler.conseal.ai`); the desktop app does the same via an authenticated request.
- **Auth (desktop app):** WorkOS SSO. Users sign in once in a browser and the app receives the token via a `cai-app://` deep link.
- **Auth (website):** WorkOS, via server-side Next.js API routes (`/api/auth/signup`, `/login`, `/logout`, `/me`, `/refresh`, `/forgot-password`, `/reset-password`, `/change-password`, `/update-profile`, `/verify-email`). Website sessions are cookie-based (sealed with a 64-char cookie secret).
- **Platforms:** Windows (NSIS installer, x64) and macOS (DMG + ZIP, Apple Silicon). Delivered via auto-updater from `distribution.conseal.ai`; direct download at `distribution.conseal.ai/latest` (the website's primary CTA points here).
- **Primary conversion path (live):** Website homepage → "Download for Windows" → desktop app install → in-app sign-in (WorkOS via browser + deep link) → free tier usage (3/day) → upgrade to Pro via the in-app button or the website `/pricing` page.

## 10. Brand Voice and Tone

Conseal's in-product text is deliberately calm, formal, and technical. The marketing voice can be warmer without becoming casual. It is never jokey, never emoji-laden, never aggressive.

**Voice attributes:** precise, reassuring, technically credible, respectful of the reader's intelligence and time.

**Tone examples (good):**

- "Your documents never leave your computer."
- "Every detection is yours to review before anything changes."
- "Built for teams who can't send their documents to someone else's cloud."
- "One tool. Five formats. No uploads."

**Tone examples (avoid):**

- "Stop worrying about leaks! 🔒" — too casual, emoji use.
- "The only redaction tool you'll ever need!!" — hype, no substance.
- "AI-powered, blockchain-secured, next-gen redaction." — buzzword stacking.
- "Because your data is basically priceless." — flippant about a serious topic.

**Style rules:**

- No emojis in marketing copy unless a campaign specifically calls for them (and never in product UI).
- No exclamation points except in rare, earned moments.
- No "game-changing," "revolutionary," "disrupting," or similar hype words.
- Sentence case for most headlines. Avoid Title Case Everywhere.
- Write in the active voice. Prefer short sentences.
- When explaining privacy, be specific about what happens locally vs. what touches the network (auth and billing are the only network calls). Vague claims erode trust with the exact audience we want to reach.

## 11. Visual Identity

- **Logo:** "Conseal" wordmark in two colors: deep navy `#0A1628` for the first four letters ("Cons"), bright blue `#2563EB` for the remaining letters ("eal") with the right side of the mark set against a solid blue tile. Clean, geometric, sans-serif.
- **Primary colors (from the live website's Tailwind theme):**
  - `brand-navy`: `#0A1628` (primary text, brand mark, navigation)
  - `brand-blue`: `#2563EB` (accent, CTAs, brand mark accent)
  - `brand-offwhite`: `#F8FAFC` (page background)
  - `brand-meta`: `#64748B` (secondary text, descriptions)
  - `brand-placeholder`: `#94A3B8` (mono labels, placeholder text, faint UI)
  - `brand-error`: `#DC2626` (error messaging only)
- **Supporting palette (desktop UI):** emerald (`#10B981`-ish range) used sparingly for success/confirm states; follow the neutral shadcn "New York" palette for anything else.
- **Typography:**
  - Headings and UI: **Space Grotesk** (Google Fonts, weights 400/500/600/700, used as `--font-sans` on the website)
  - Monospace / technical / code / stat tags: **JetBrains Mono** (Google Fonts, weights 400/500, used as `--font-mono` on the website)
- **Website type scale (reference for web collateral):** H1 48px/bold/-0.02em · H2 32px/bold · H3 24px/bold · Body-lg 18px · Body-md 16px · Label/Meta 12px. Tight letter-spacing on large headings.
- **UI aesthetic:** shadcn/ui "New York" style, neutral base, minimal chrome. The website and desktop share: flat surfaces, sharp corners (`rounded-none` is dominant on cards), thin borders, soft hover shadows. Formal, software-tool feel rather than consumer-app feel.
- **Signature UI motifs (reuse in collateral):** mono-font stat badges in uppercase (e.g., `5+ FILE TYPES`, `0 BYTES UPLOADED`); step numbering with leading zeros (`Step 01`, `Step 02`); status strip copy in mono such as "Session: Encrypted · Local Processing: Active"; a "100% Local Processing" badge on the hero document visualization.
- **Motion:** Framer Motion on the website — scroll-track-pinned sections for How It Works and Use Cases, viewport-triggered fades on Why Conseal, staggered reveal cards. Respects `prefers-reduced-motion`. Keep campaign imagery compatible with this restrained, purposeful animation language.
- **Imagery direction:** abstract document-centric visuals, diagrammatic flows, privacy metaphors. Avoid stock photography of happy office workers. Avoid cartoon padlocks, hoodie hackers, or green Matrix rain.

## 12. Channels and Presence

Current surface area to reference in copy:

- Product website: conseal.ai (live, hosted on AWS Amplify with SSR, DNS via Cloudflare in DNS-only mode, auto-deploys from `master` branch of `Sprintfour/conseal-website-v2`)
- Website section anchors (useful for deep-linking in campaigns): `/#problem`, `/#how-it-works`, `/#use-cases`, `/#why-conseal`, `/pricing`, `/login`, `/signup`, `/forgot-password`, `/account`
- Website primary CTA: "Download for Windows" → `https://distribution.conseal.ai/latest`
- Website secondary CTA: "See how it works" → `#how-it-works`
- Distribution endpoint: distribution.conseal.ai
- Auth service: auth-butler.conseal.ai
- Company: sprintfour.com
- Legal contact: <legal@conseal.ai>

Channels to plan for in campaigns (non-exhaustive, for the marketing agent to propose against):

- Direct search: "document redaction software," "redact PII locally," "HIPAA-safe redaction tool," "PDF redaction without uploading." Also AI-era terms: "how to use ChatGPT with confidential documents," "redact before AI," "private ChatGPT for legal documents," "PII redaction for LLM prompts."
- LinkedIn content aimed at legal, compliance, and clinical data audiences.
- Industry publications: legal technology newsletters, healthcare IT, fintech compliance.
- Developer/technical communities where privacy-sensitive audiences congregate (indirect, thoughtful engagement — not product spam).
- India-specific outreach emphasizing Aadhaar/PAN/GSTIN coverage and DPDP-aligned local processing.
- AI-tool-adjacent communities (r/ChatGPTPro, r/LocalLLaMA, legal-tech Slacks) where the exact pain is "I want to use this AI but my documents have PII."

## 13. Competitive Context

Not a complete landscape; use this as a starting point, not as copy for a battlecard.

- **Adobe Acrobat Redaction Tool.** Industry default, powerful, widely licensed. Weaknesses: historical cases of text leaking under cover, no AI-assisted detection, expensive enterprise licensing, opaque handling of document content when Adobe's cloud features are enabled.
- **Foxit / Nitro PDF.** Similar positioning to Acrobat. Price-competitive but similar cover-vs-burn concerns.
- **iManage Workshare, Litera, and law-firm suites.** Enterprise-focused; strong workflow, weaker automatic detection; heavy deployment footprint.
- **Online redaction SaaS (e.g., Redactable, Docsumo-style tools, PDF.co).** Fast, AI-powered, and usually cloud-processed. Disqualifying for most of Conseal's target audiences because documents are uploaded.
- **Manual tooling (Word highlighter, black rectangles in PDF editors).** Common, leaky, and slow. A de-facto competitor wherever redaction isn't formalized.

**Our wedge against all of these:** local-only processing + AI-assisted detection + genuine burn + reversible-via-vault, in one desktop app.

## 14. Do and Don't (for every asset)

**Do:**

- Lead with "local" or "on-device" in any privacy-focused piece. This is our biggest differentiator; don't bury it.
- Reference specific PII categories when they fit the audience (SSN + medical record for clinicians, Aadhaar + PAN for Indian enterprises, SSN + credit card for fintech).
- Use screenshots or product imagery where possible; the UI is clean and credible and sells itself.
- Name the file formats explicitly when space allows. "Works with PDF, Word, and text" beats "broad format support."
- Mention the free tier (3 operations per day) when the CTA is "try it."

**Don't:**

- Don't claim regulatory certifications Conseal has not published.
- Don't imply 100% detection accuracy or "AI replaces your compliance review."
- Don't compare directly to Adobe by name in paid copy without legal review.
- Don't use emojis in product UI or formal collateral. Marketing social posts may use them sparingly if the campaign requires.
- Don't call it "Anonymizer" in external copy — that label appears in one in-product string ("Get Anonymizer Pro") but the canonical product name is **Conseal Pro**. Flag that string as something to reconcile internally.
- Don't describe the vault file as "encrypted" in copy without confirming the current implementation; the subscription feature list mentions "Encrypted .conseal vault" — verify with engineering before leading with that claim in regulated-industry messaging.
- Don't position Conseal as a generic "AI document tool." It has one job and does it well.

## 15. Short Copy Library (Seed Material)

Two categories: live copy already on conseal.ai (reuse as-is for continuity) and seed drafts the agent can remix.

### 15a. Live website copy (treat as canonical for any work that sits near the homepage)

**Homepage hero:**

- Eyebrow label: `Private by design`
- Headlines: "Conseal removes PII before AI sees it." / "Your files stay on your machine — always."
- Primary CTA: `Download for Windows` → `https://distribution.conseal.ai/latest`
- Secondary CTA: `See how it works` → `#how-it-works`
- Hero status strip: `Session: Encrypted · Local Processing: Active`
- Hero badge on the document visualization: `100% Local Processing`

**Meta / social:**

- Default title: `Conseal - Use AI on any document. Privately.`
- Homepage title: `Conseal | Remove PII Before AI sees it`
- Homepage description: `Remove PII from documents before AI processing. 100% local. Complete privacy. Download for Windows.`
- Open Graph title: `Conseal — Use AI on any document. Privately.`
- Open Graph description: `Conseal removes personally identifiable information from documents before you share them with AI. 100% local. Complete privacy guaranteed.`

**Problem section — heading:** `You want AI. Compliance says no.`

**How It Works section:**

- Heading: `Three steps. Zero data leaves your machine.`
- Step 01 — **Drop your file**: "Upload PDF, Word, or text. Conseal scans it instantly."
- Step 02 — **Review detections**: "See exactly what PII was found. Edit redactions if needed."
- Step 03 — **Export & Restore**: "Save your clean file. Keep an encrypted copy for later."

**Why Conseal — pillar cards (use the exact stat tags):**

- `5+ FILE TYPES` — Files, not just text — "Process entire documents, spreadsheets, and PDFs."
- `0 BYTES UPLOADED` — 100% Local — "Zero data leaves your machine. Complete privacy guaranteed."
- `ANY LLM` — Any AI tool — "Works seamlessly with ChatGPT, Claude, Gemini, and more."
- `94%+ ACCURACY` — Smart detection — "Combines pattern matching with AI for maximum accuracy."

**Use Cases section:**

- Heading: `Built for privacy-first professionals`
- Legal — "Contract review without the risk." / "Review NDAs and agreements with AI. Conseal redacts client names, contract values, and confidential terms."
- Healthcare — "Patient data stays private." / "Extract insights from medical records using AI. Conseal masks patient identifiers, diagnoses, and treatment details."
- Finance — "Analyze deals without exposing positions." / "Leverage AI on term sheets and prospectuses. Conseal redacts counterparty names, valuations, and deal terms."
- HR — "Screen resumes without the liability." / "Use AI to parse CVs. Conseal masks names, addresses, dates, and employment history."
- Consulting — "Keep client data safe." / "Remove sensitive business information before sharing reports with AI."
- Research — "Anonymize research data." / "Strip identifying information from datasets before AI model training."

**Pricing section:**

- Headline: `Redact. Process locally. Restore anytime.`
- Subheadline: `100% local processing means your sensitive data never leaves your device.`
- Monthly card badge: `Most flexible`. Price `$12.99/month`. Billing note: `Billed monthly`. CTA: `Upgrade to Pro`.
- Annual card badge: `Save 23%`. Price `$9.99/month`. Billing note: `Billed $119.88/year`. CTA: `Upgrade to Pro`.
- Feature bullets (in order): Automatic PII redaction · Restore originals anytime · Unlimited operations · 100% offline · PDF, DOCX, RTF, TXT, ODT.

### 15b. Seed drafts (the agent may remix, extend, or replace in new collateral)

**Tagline candidates:**

- Use AI on any document. Privately. *(currently live)*
- Redact documents. Keep them yours.
- Privacy-first redaction. On your desktop.
- The redaction tool that never sees your documents.
- Find it, review it, burn it in.
- Your documents. Your AI. Nothing in between.

**Elevator (30 seconds):**
> Conseal is a desktop app that lets regulated teams use ChatGPT, Claude, Gemini, and any other AI tool on sensitive documents — safely. It finds personally identifiable information — names, IDs, account numbers, medical data — and lets you review each detection before burning it out of the file. Everything happens on your computer. Your documents never leave the device. And if you need to reverse a redaction later, a private vault file restores the original text for anyone you share it with.

**Landing-page hero alternative (not currently live):**

- H1: Redact documents without uploading them.
- Sub: Conseal finds and removes sensitive information on your device. PDF, Word, text, ODT, RTF. AI-assisted detection, reversible when you need it.
- CTA: Download for Windows · Download for macOS · Start free (3 operations/day)

**LinkedIn post (draft, compliance audience):**
> Most redaction tools ask you to upload the document. If you're in legal, healthcare, or financial services, that's often the end of the conversation. Conseal runs entirely on your desktop — OCR and NER detection happen in the app, not in someone else's cloud. You review each detection and burn redactions into a clean output file. PDF, Word, text, ODT, RTF. Free for your first three documents a day.

**LinkedIn post (draft, AI-adoption angle):**
> Your team has access to ChatGPT Enterprise, Claude Pro, Copilot — and they still can't use them on the documents that would actually benefit. The legal review. The medical record. The term sheet. Compliance won't sign off on uploads. Conseal redacts the document on the user's computer, hands them a clean copy, and that copy can go into whatever AI tool the team already pays for. The PII stays on the device. Free to try: three documents a day.

## 16. Glossary

- **PII** — Personally Identifiable Information. Any data that could identify a specific individual.
- **PHI** — Protected Health Information. A HIPAA-scoped subset of PII.
- **NER** — Named Entity Recognition. ML technique for finding names, organizations, and locations in text.
- **OCR** — Optical Character Recognition. Extracts text from images / scanned pages.
- **Burn / burn-in** — Destructively apply redactions so the underlying text is no longer in the file.
- **Vault (`.conseal` file)** — Companion file holding the mapping from redaction labels to original values, for controlled unredaction later.
- **Redact / Unredact** — The two workflows in Conseal: remove PII, or restore it using a vault.
- **WorkOS** — Third-party identity provider used for SSO-based authentication.
- **Stripe** — Third-party payment processor used for subscription billing.
- **Electron** — Desktop application framework. Worth mentioning only in technical collateral; consumers don't need to know.

## 17. Open Items and Things to Confirm With Engineering / Founders

Flag these before publishing anything that depends on them:

- Exact enterprise / team pricing, if any. Current known tiers are personal: monthly $12.99 and yearly $119.88.
- Vault encryption specifics (the desktop pricing card says "Encrypted .conseal vault"; the website's How It Works step 03 says "Keep an encrypted copy for later." Verify the current encryption implementation with engineering before leaning on "encrypted" in compliance copy.)
- Certification status for HIPAA BAA availability, SOC 2, or ISO 27001 — don't claim these until confirmed.
- Localization status. UI text appears English-only today; confirm before targeting non-English-speaking segments. Note: the website is English-only; India-specific PII coverage is the only explicitly internationalized surface today.
- In-product string "Get Anonymizer Pro" — reconcile with the canonical product name "Conseal Pro" used on the website's pricing page.
- Customer quotes, case studies, logos — none are documented here; request from the founders before using social proof copy.
- **Accuracy claim.** The website's "Smart detection" pillar claims "94%+ accuracy." Confirm the test corpus, entity types in scope, and measurement methodology with engineering before reusing the number in RFPs, sales decks, or paid ads. Safe to reuse in web/social contexts adjacent to the homepage; not safe as a standalone evidentiary claim.
- **File-type coverage inconsistency.** The website's "Files, not just text" pillar says "documents, spreadsheets, and PDFs," but the pricing page's feature list (and the desktop app's actual supported formats) is PDF, DOCX, RTF, TXT, ODT — no spreadsheet support (xlsx/csv) shipped today. Either ship spreadsheet support or update the pillar copy before campaigns lean on it.
- **Domain metadata inconsistency.** The website's `src/app/layout.tsx` sets `metadataBase: new URL("https://conseal.app")` while `sitemap.ts`, `public/robots.txt`, and `src/lib/config.ts` all use `https://conseal.ai`. The live site is conseal.ai. Flag this to the website team; until fixed, do not publish assets that reference `conseal.app`.
- **Platform parity on CTAs.** The homepage's primary CTA is "Download for Windows." The product ships for both Windows and macOS. Before running paid campaigns targeting Mac-first audiences (designers, journalists, some research segments), confirm whether the macOS build is fully release-ready and ask product whether the hero should gain a second CTA.
- **"Any LLM" claim.** The website pillar "Any AI tool" names ChatGPT, Claude, and Gemini. Conseal doesn't technically integrate with any of them — it outputs a clean file the user then uses with their tool of choice. This is fine as positioning but confirm with the founders that marketing materials should not imply a native integration, API connector, or "one-click send to ChatGPT" feature.
- **Stripe savings math.** The annual plan's badge reads "Save 23%" (computed from $12.99/mo vs. $9.99/mo). Keep that number; don't round to "Save 25%" or "a quarter off" in campaign derivatives.

---

## 18. Conseal Website Reference (for any agent producing web-adjacent collateral)

Capture of the live website's structure so an agent can plan landing pages, sub-pages, paid-traffic destinations, or website additions without re-reading the codebase.

**Stack:** Next.js 15 (App Router) · Tailwind CSS v4 · shadcn/ui · Framer Motion · TypeScript. Hosted on AWS Amplify (SSR), CI/CD from `master`, domain via Cloudflare DNS-only.

**Site map (live):**

- `/` — homepage, single long-scroll page composed of Hero + DocumentViz, Problem, HowItWorks, UseCases, WhyConseal sections
- `/pricing` — dedicated pricing page with two cards (Monthly, Annual) and a feature list
- `/login` — WorkOS-backed email + password login
- `/signup` — WorkOS-backed account creation
- `/forgot-password` — password recovery
- `/account` — authenticated user account (profile)
- `/account/change-password` — authenticated password change
- `/auth/callback` — post-auth redirect target
- `/auth/logout` — logout handling

**Navigation (live):** Logo "Conseal" (wordmark) · links: Problem · How It Works · Use Cases · Why Conseal · Pricing. Right side: Sign in · Sign up.

**Tone on the site:** The site uses slightly warmer, more punctuated copy than the desktop UI — short declarative lines, uppercase mono stat tags, sentence-case headlines, sharp negative assertions ("Compliance says no.") used intentionally. It is still not casual: no emojis, no exclamation points, no hype words.

**Signature components to keep consistent in any new page:**

- `MonoBadge` — uppercase JetBrains Mono pill used for section labels and stat tags
- Pillar / step / use-case cards — `bg-brand-accent-soft` with a thin `border-brand-blue/20`, `rounded-none`, 32–40px padding, soft navy shadow on hover
- Section layouts — full-viewport (`min-h-[100dvh]`) with pinned sticky reveals on How It Works and Use Cases (Framer Motion scroll-driven)
- Pricing cards — white with thin border for monthly; `bg-brand-accent-soft` with a 2px `border-brand-blue` for annual; the annual card uses a white-on-blue "Save 23%" tag

**CTAs and their destinations:**

- Hero primary → `https://distribution.conseal.ai/latest`
- Hero secondary → `#how-it-works`
- Pricing cards → Stripe checkout session created by the `/api/billing/checkout` route, which talks to auth-butler
- Nav sign-up → `/signup`
- Nav sign-in → `/login`

**What the agent should not touch without approval:** the WorkOS auth flow, the Stripe billing flow, and any of the `/api` routes. Those are product surface, not marketing.

---

## Usage notes for the marketing agent

- Anything not in this file is not confirmed. Ask before inventing a stat, certification, customer name, or feature.
- Prefer specificity over superlatives. "Runs on your device" beats "best-in-class privacy."
- When producing an asset, state which pillars (Section 6) it leads with and which audience (Section 4) it targets. That metadata helps review.
- For any claim touching regulation (HIPAA, GDPR, SOC 2, DPDP, PCI), route through the open items list (Section 17) first.
- For any copy intended to sit alongside the homepage or pricing page, reuse the live wording in Section 15a verbatim where possible. Breaking continuity between a paid ad and the destination page erodes conversion.
- When in doubt, the product's own license and CLAUDE.md tone is the reference: formal, precise, no emojis, no hype.
- **Source-of-truth precedence** (use when two parts of this file seem to contradict each other):
  1. The live website (Sections 15a and 18) — what visitors see today.
  2. The pricing page feature list (Section 9) — what Pro actually includes.
  3. The product code realities cited in Sections 2, 7, 8.
  4. Strategic pillars and seed copy (Sections 6, 15b) — directional, editable.
  Contradictions should be flagged as Open Items (Section 17), not papered over in new copy.
