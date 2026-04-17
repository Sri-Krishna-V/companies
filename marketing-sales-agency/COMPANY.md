---
name: Marketing & Sales Agency
description: A product-agnostic marketing and sales agency with 8 specialist agents across Marketing and Sales divisions — covering research, content, community, paid media, SDR, deal strategy, and executive orchestration
slug: marketing-sales-agency
schema: agentcompanies/v1
version: 1.0.0
license: MIT
authors:
  - name: Paperclip Operator
goals:
  - Deliver full-funnel marketing and sales execution for any B2B or B2C client
  - Combine agency-agents personality layer with coreyhaines31 tactical skill frameworks
  - Produce deliverables that match or exceed what Okara.ai does, plus outbound sales which Okara doesn't cover
metadata:
  sources:
    - kind: github-dir
      repo: msitarzewski/agency-agents
      path: .
      commit: 783f6a72bfd7f3135700ac273c619d92821b419a
      attribution: AgentLand Contributors
      license: MIT
      usage: referenced
    - kind: skills-package
      package: coreyhaines31/marketingskills
      url: https://skills.sh/coreyhaines31/marketingskills
      attribution: Corey Haines
      license: MIT
      usage: installed
---

A product-agnostic marketing and sales agency with 8 agents across 2 divisions. Each agent's role definition is referenced from the [agency-agents](https://github.com/msitarzewski/agency-agents) repo. Each agent's tactical playbook is installed as skills from [coreyhaines31/marketingskills](https://skills.sh/coreyhaines31/marketingskills).

## How it works

The CEO sits at the top. The CMO owns the awareness → consideration funnel with 4 specialists reporting in (Research Analyst, Content Strategist, Community Manager, Paid Media Strategist). The CSO owns the leads → closed funnel with 1 specialist (SDR). The Research Analyst is the connective tissue — its intel feeds Content, Community, Paid Media, and SDR.

## Divisions

| Division | Agents | Head | Focus |
|---|---|---|---|
| Marketing | 5 (incl. CMO) | CMO | Organic content, community, SEO, paid ads, research |
| Sales | 2 (incl. CSO) | CSO | Outbound prospecting, deal strategy, pipeline |

## Leadership

| Role | Slug | Reports To |
|---|---|---|
| CEO | ceo | — |
| CMO | cmo | ceo |
| CSO | cso | ceo |

Generated with inspiration from [agency-agents](https://github.com/msitarzewski/agency-agents) and [paperclipai/companies](https://github.com/paperclipai/companies).
