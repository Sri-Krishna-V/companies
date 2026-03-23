# ClawTeam Capital

> AI-powered investment analysis through specialized multi-agent teams that research securities from multiple angles and consolidate signals into risk-adjusted portfolio decisions

> An [Agent Company](https://agentcompanies.io) based on [ClawTeam](https://github.com/HKUDS/ClawTeam) — a multi-agent orchestration CLI for spawning agents, managing tasks, and coordinating work through mailbox messaging and git worktree isolation

![Org Chart](images/org-chart.png)

## What's Inside

> This is an [Agent Company](https://agentcompanies.io) package from [Paperclip](https://paperclip.ing)

| Content | Count |
|---------|-------|
| Agents | 7 |
| Skills | 1 |

### Agents

| Agent | Role | Reports To |
|-------|------|------------|
| Buffett Analyst | Engineer | portfolio-manager |
| Fundamentals Analyst | Engineer | portfolio-manager |
| Growth Analyst | Engineer | portfolio-manager |
| Portfolio Manager | Manager | — |
| Risk Manager | Manager | portfolio-manager |
| Sentiment Analyst | Engineer | portfolio-manager |
| Technical Analyst | Engineer | portfolio-manager |

### Skills

| Skill | Description | Source |
|-------|-------------|--------|
| clawteam | Multi-agent team orchestration CLI for spawning agents, managing tasks, and coordinating work through mailbox messaging and git worktree isolation | [github](https://github.com/HKUDS/ClawTeam/blob/main/skills/clawteam/SKILL.md) |

## Getting Started

```bash
pnpm paperclipai company import this-github-url-or-folder
```

See [Paperclip](https://paperclip.ing) for more information.

---
Exported from [Paperclip](https://paperclip.ing) on 2026-03-23
