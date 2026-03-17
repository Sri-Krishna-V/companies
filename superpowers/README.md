# Superpowers Dev Shop

A disciplined software development company powered by the [Superpowers](https://github.com/obra/superpowers) workflow — brainstorm, plan, build with TDD, review, and ship.

## How It Works

Every piece of work flows through a **pipeline** of four agents, each enforcing quality at their stage:

1. **CEO** brainstorms the idea with the user, explores design approaches, and produces a detailed implementation plan
2. **Lead Engineer** sets up an isolated worktree, implements using strict TDD (red-green-refactor), and dispatches parallel subagents for complex work
3. **Code Reviewer** reviews the implementation against the plan, verifies correctness, and gates quality
4. **Release Engineer** ships the approved code — merge, PR, or cleanup

## Org Chart

| Agent | Title | Reports To | Skills |
|-------|-------|-----------|--------|
| CEO | Chief Executive Officer | — | brainstorming, writing-plans, using-superpowers |
| Lead Engineer | Lead Software Engineer | CEO | test-driven-development, subagent-driven-development, executing-plans, using-git-worktrees, dispatching-parallel-agents, systematic-debugging |
| Code Reviewer | Senior Code Reviewer | CEO | requesting-code-review, receiving-code-review, verification-before-completion |
| Release Engineer | Release Engineer | CEO | finishing-a-development-branch |

All 14 skills are referenced from [obra/superpowers](https://github.com/obra/superpowers) (MIT). An additional meta-skill (`writing-skills`) is included for creating new skills.

## Getting Started

```bash
paperclipai company import --from ~/paperclipai/companies/superpowers
```

## References

- Source repo: [obra/superpowers](https://github.com/obra/superpowers)
- Agent Companies spec: [agentcompanies.io/specification](https://agentcompanies.io/specification)
- Paperclip: [github.com/paperclipai/paperclip](https://github.com/paperclipai/paperclip)
