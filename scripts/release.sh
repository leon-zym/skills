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

if [[ -n "$(git status --porcelain)" ]]; then
  echo "error: working tree is dirty; commit before releasing" >&2
  exit 1
fi
if git rev-parse -q --verify "refs/tags/$TAG" >/dev/null; then
  echo "error: tag $TAG already exists" >&2
  exit 1
fi

ARCHIVES=()
for skill_dir in skills/*/; do
  skill="$(basename "$skill_dir")"
  [[ -f "$skill_dir/SKILL.md" ]] || continue
  mkdir -p "$STAGE/$skill"
  rsync -a --exclude='.DS_Store' "$skill_dir" "$STAGE/$skill/"
  (cd "$STAGE" && zip -rqX "$skill.zip" "$skill" -x '*.DS_Store')
  ARCHIVES+=("$STAGE/$skill.zip")
  echo "packaged $skill.zip"
done

[[ ${#ARCHIVES[@]} -gt 0 ]] || { echo "error: no skills found under skills/" >&2; exit 1; }

git tag -a "$TAG" -m "$TAG"
git push origin "$TAG"
gh release create "$TAG" "${ARCHIVES[@]}" --title "$TAG" --generate-notes
