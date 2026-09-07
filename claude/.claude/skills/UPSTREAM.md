# Vendored skill baseline

These skills are vendored copies, not a live install. Do not run `npx skills update` -
it has no record that they were `--copy` installs and will replace them with symlinks.

Pinned upstream commit (all skills except `jj-resolve`, which is hand-written):

    mattpocock/skills @ 3cca18b368ae95cdbdebbff572ccafa662551015

Verified at vendoring time: all 100 files across 37 skills matched this commit exactly.

## Pulling upstream changes

```fish
cd ~/.dotfiles
git fetch skills-upstream
set OLD (grep -oE '[0-9a-f]{40}' claude/.claude/skills/UPSTREAM.md)

# what changed upstream since the pin
git log --oneline $OLD..skills-upstream/main -- skills
git diff --stat $OLD..skills-upstream/main -- skills ':(exclude)skills/*/README.md'

# apply it onto the customized copies (exit 1 means conflicts to resolve, not failure)
git diff $OLD..skills-upstream/main -- skills ':(exclude)skills/*/README.md' \
  | git apply -p3 --directory=claude/.claude/skills --3way

# resolve conflicts, then re-pin the SHA above and commit
```

`-p3` strips `a/skills/<category>/` so upstream's `skills/<category>/<name>/SKILL.md`
lands at the flat `claude/.claude/skills/<name>/SKILL.md`. The `:(exclude)` keeps the
five category-level `README.md` files from all colliding at the vendored root.
