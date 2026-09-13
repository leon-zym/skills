#!/usr/bin/env bash
# Package every skill in skills/ as a release archive and publish a GitHub release.
#
#   ./scripts/release.sh 1.0.0
#
# Each archive contains a single top-level <skill>/ directory, so it can be
# unzipped straight into an agent's skills directory — and installed directly
# with `npx skills add <archive-url>`.
set -euo pipefail

VERSION="${1:?usage: release.sh <version>  (e.g. 1.0.0)}"
TAG="v${VERSION}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

cd "$ROOT"

# owner/repo for the release URLs. `gh` is authoritative; fall back to parsing
# the origin remote (https, git@host:owner/repo, and ssh:// forms).
SLUG="$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)"
if [[ -z "$SLUG" ]]; then
  SLUG="$(git remote get-url origin 2>/dev/null \
    | sed -E 's#^[a-z+]+://##; s#^([^@/]+@)?[^/:]+[:/]##; s#\.git$##')"
fi
[[ "$SLUG" == */* ]] || { echo "error: could not derive owner/repo for the origin remote" >&2; exit 1; }

if [[ -n "$(git status --porcelain)" ]]; then
  echo "error: working tree is dirty; commit before releasing" >&2
  exit 1
fi
if git rev-parse -q --verify "refs/tags/$TAG" >/dev/null; then
  echo "error: tag $TAG already exists" >&2
  exit 1
fi

ARCHIVES=()
ROWS=()
for skill_dir in skills/*/; do
  skill="$(basename "$skill_dir")"
  [[ -f "$skill_dir/SKILL.md" ]] || continue
  mkdir -p "$STAGE/$skill"
  rsync -a --exclude='.DS_Store' "$skill_dir" "$STAGE/$skill/"
  (cd "$STAGE" && zip -rqX "$skill.zip" "$skill" -x '*.DS_Store')
  ARCHIVES+=("$STAGE/$skill.zip")

  # First line of the description frontmatter field, for the release table.
  description="$(awk '/^description:/{sub(/^description:[[:space:]]*/, ""); print; exit}' "$skill_dir/SKILL.md")"
  ROWS+=("| \`$skill\` | [\`$skill.zip\`](https://github.com/$SLUG/releases/latest/download/$skill.zip) | $description |")
  echo "packaged $skill.zip"
done

[[ ${#ARCHIVES[@]} -gt 0 ]] || { echo "error: no skills found under skills/" >&2; exit 1; }

NOTES="$STAGE/notes.md"
{
  echo "| Skill | Download | Description |"
  echo "| --- | --- | --- |"
  printf '%s\n' "${ROWS[@]}"
  echo
  echo "Unzip into your agent's skills directory (\`~/.agents/skills/\`, \`~/.claude/skills/\`, …), or install directly with \`npx skills add <archive-url>\`."
  echo
  echo "**Full Changelog**: https://github.com/$SLUG/commits/$TAG"
} > "$NOTES"

git tag -a "$TAG" -m "$TAG"
git push origin "$TAG"
gh release create "$TAG" "${ARCHIVES[@]}" --title "$TAG" --notes-file "$NOTES"
