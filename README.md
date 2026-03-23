# Paperclip Companies

Pre-built agent companies for [Paperclip](https://github.com/paperclipai/paperclip). Each directory contains a complete company configuration — agents, skills, and workflows — ready to deploy.

## Companies

### [GStack](./gstack)

An engineering company built around [Garry Tan's gstack workflow](https://github.com/garrytan/gstack). Work flows through distinct cognitive modes: founder taste, technical planning, paranoid review, fast execution, and systematic QA.

**Agents:** CEO, CTO, Staff Engineer, Release Engineer, QA Engineer

### [Superpowers Dev Shop](./superpowers)

A disciplined development company built on [Jesse Vincent's Superpowers](https://github.com/obra/superpowers) methodology. Enforces test-driven development, systematic debugging, and quality gates at every stage.

**Agents:** CEO, Lead Engineer, Code Reviewer, Release Engineer

### [Default](./default)

Baseline agent configurations (CEO, default roles) used as the starting point when creating new companies.

## Structure

Each company directory contains:

- `COMPANY.md` — company metadata, description, and goals
- `agents/` — agent configurations with role-specific prompts
- `skills/` — workflow skills available to agents
- `README.md` — detailed company documentation
- `.paperclip.yaml` — Paperclip configuration

## Usage

These companies are managed by the Paperclip platform. See the [Paperclip docs](https://github.com/paperclipai/paperclip) for setup and deployment.
