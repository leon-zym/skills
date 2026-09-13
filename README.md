# skills

My personal collection of [Agent Skills](https://agentskills.io) — reusable instruction sets for AI coding agents.

[![skills.sh](https://skills.sh/b/leon-zym/skills)](https://skills.sh/leon-zym/skills)

## Install

```bash
# Everything in this repository
npx skills add leon-zym/skills --all

# A single skill
npx skills add leon-zym/skills --skill coordinate-work
```

Add `-g` to install globally (`~/.agents/skills/` et al.) instead of into the current project, and `-a <agent>` to target a specific agent:

```bash
npx skills add leon-zym/skills --skill coordinate-work -g -a claude-code -y
```

List what a source offers without installing it:

```bash
npx skills add leon-zym/skills --list
```

## Skills

| Skill | Description |
| --- | --- |
| [`coordinate-work`](skills/coordinate-work/SKILL.md) | Runs a delegation-based coding workflow: operating agreement, recoverable state, coherent worker assignments, event-driven coordination, independent review and integration. |

## License

MIT — see [LICENSE](LICENSE).
