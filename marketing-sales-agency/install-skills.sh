#!/usr/bin/env bash
# Run this script from the marketing-sales-agency/ directory root.
# It installs all coreyhaines31/marketingskills required by each agent.
# See: https://skills.sh/coreyhaines31/marketingskills

set -euo pipefail

echo "=== Installing prerequisite skill ==="
npx skills add coreyhaines31/marketingskills --skill product-marketing-context

echo ""
echo "=== Installing Tier 1 skills ==="
npx skills add coreyhaines31/marketingskills --skill copywriting
npx skills add coreyhaines31/marketingskills --skill social-content
npx skills add coreyhaines31/marketingskills --skill content-strategy
npx skills add coreyhaines31/marketingskills --skill email-sequence
npx skills add coreyhaines31/marketingskills --skill analytics-tracking
npx skills add coreyhaines31/marketingskills --skill seo-audit
npx skills add coreyhaines31/marketingskills --skill paid-ads
npx skills add coreyhaines31/marketingskills --skill marketing-psychology
npx skills add coreyhaines31/marketingskills --skill cold-email
npx skills add coreyhaines31/marketingskills --skill sales-enablement
npx skills add coreyhaines31/marketingskills --skill ad-creative
npx skills add coreyhaines31/marketingskills --skill revops

echo ""
echo "=== Installing Tier 2 skills ==="
npx skills add coreyhaines31/marketingskills --skill pricing-strategy
npx skills add coreyhaines31/marketingskills --skill page-cro
npx skills add coreyhaines31/marketingskills --skill competitor-alternatives
npx skills add coreyhaines31/marketingskills --skill ab-test-setup
npx skills add coreyhaines31/marketingskills --skill churn-prevention
npx skills add coreyhaines31/marketingskills --skill ai-seo
npx skills add coreyhaines31/marketingskills --skill launch-strategy
npx skills add coreyhaines31/marketingskills --skill lead-magnets
npx skills add coreyhaines31/marketingskills --skill customer-research

echo ""
echo "=== All skills installed successfully ==="
echo "Next step: populate .agents/product-marketing-context.md with your client's positioning before running any agent."
