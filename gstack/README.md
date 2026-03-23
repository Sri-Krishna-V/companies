# GStack

An agent company powered by [gstack](https://github.com/garrytan/gstack/tree/main) workflow skills. Five agents, each operating in a distinct cognitive mode, connected in a pipeline that takes an idea from product vision to shipped and tested.

## How It Works

Work flows through the company as a pipeline:

1. **CEO** receives a feature idea and rethinks it in founder mode — finds the 10-star product
2. **CTO** takes the product-approved plan and locks the technical execution — architecture, data flow, edge cases, test coverage
3. **Staff Engineer** runs a paranoid structural review on the branch before it ships
4. **Release Engineer** lands the plane — merge main, run tests, bump version, push, open PR
5. **QA Engineer** tests the shipped feature in a headless browser and reports back with evidence

The philosophy: planning is not review, review is not shipping, founder taste is not engineering rigor. Each agent is a specialist you summon for the right job.

## Org Chart

| Agent | Title | Reports To | Skills |
|-------|-------|-----------|--------|
| CEO | Chief Executive Officer | — | plan-ceo-review |
| CTO | Chief Technology Officer | CEO | plan-eng-review, retro |
| Staff Engineer | Staff Engineer | CTO | review |
| Release Engineer | Release Engineer | CTO | ship |
| QA Engineer | QA Engineer | CTO | browse, qa, setup-browser-cookies |

## Skills

All skills are referenced from [garrytan/gstack](https://github.com/garrytan/gstack) (not copied). The company package contains lightweight SKILL.md files that point to the upstream source at commit `bb46ca6`.

| Skill | Description |
|-------|-------------|
| plan-ceo-review | CEO/founder-mode plan review |
| plan-eng-review | Eng manager-mode technical planning |
| review | Pre-landing PR review for structural issues |
| ship | Ship workflow — merge, test, version, push, PR |
| browse | Fast headless browser for QA and dogfooding |
| qa | Systematic QA testing with structured reports |
| setup-browser-cookies | Import real browser cookies for authenticated testing |
| retro | Weekly engineering retrospective with trend tracking |

## Getting Started

Import this company into Paperclip:

```bash
paperclipai company import --from /path/to/gstack
```

Or preview what will be imported:

```bash
paperclipai company import --from /path/to/gstack --dry-run
```

## References

- Source repo: [garrytan/gstack](https://github.com/garrytan/gstack/tree/main)
- Agent Companies spec: [agentcompanies.io/specification](https://agentcompanies.io/specification)
- Paperclip: [github.com/paperclipai/paperclip](https://github.com/paperclipai/paperclip)

## License

MIT — see [LICENSE](LICENSE)
