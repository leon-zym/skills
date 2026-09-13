# skills

My personal collection of [Agent Skills](https://agentskills.io) — reusable instruction sets for AI coding agents.

[![skills.sh](https://img.shields.io/badge/skills.sh-leon--zym%2Fskills-blue)](https://skills.sh/leon-zym/skills)
[![release](https://img.shields.io/github/v/release/leon-zym/skills)](https://github.com/leon-zym/skills/releases/latest)
[![license](https://img.shields.io/github/license/leon-zym/skills)](LICENSE)

## Install

With the [skills CLI](https://github.com/vercel-labs/skills):

```bash
# Everything in this repository
npx skills add leon-zym/skills --all

# A single skill
npx skills add leon-zym/skills --skill coordinate-work
```

Add `-g` to install globally instead of into the current project, and `-a <agent>` to target a specific agent:

```bash
npx skills add leon-zym/skills --skill coordinate-work -g -a claude-code -y
```

List what this repository offers without installing anything:

```bash
npx skills add leon-zym/skills --list
```

## Install without the CLI

Each skill is also published as a zip archive on the [releases page](https://github.com/leon-zym/skills/releases/latest). Every archive unpacks to a single `<skill>/` directory, so it can be dropped into an agent's skills directory as-is.

```bash
# Download and unpack into the current project
curl -LO https://github.com/leon-zym/skills/releases/latest/download/coordinate-work.zip
unzip coordinate-work.zip -d .agents/skills/
```

Use `~/.agents/skills/` (or `~/.claude/skills/`) instead of `.agents/skills/` for a global install. The CLI can also consume a release archive URL directly:

```bash
npx skills add https://github.com/leon-zym/skills/releases/latest/download/coordinate-work.zip
```

## Skills

| Skill | Description |
| --- | --- |
| [`coordinate-work`](skills/coordinate-work/SKILL.md) | Runs a delegation-based coding workflow: operating agreement, recoverable state, coherent worker assignments, event-driven coordination, independent review and integration. |

## License

MIT — see [LICENSE](LICENSE).
