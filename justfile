_default:
    @just --list --unsorted

start:
  pnpm start

start-prod:
  pnpm start:prod

resume:
  cd src/_resume && \
    pandoc -s \
      --to=pdf \
      --lua-filter filter.lua \
      --pdf-engine=tectonic \
      --template mcdowell.tex \
      --pdf-engine-opt=-Zsearch-path=${FONT_DIR} \
      cv.md \
      -o cv.pdf

html-resume:
  cd src/_resume && \
    pandoc -s \
      --to=html \
      --lua-filter filter.lua \
      cv.md \
      -o -

native-resume:
  cd src/_resume && \
    pandoc -s \
      --to=native \
      --lua-filter filter.lua \
      cv.md \
      -o -

update-deps:
  #!/usr/bin/env bash
  set -euxo pipefail
  nix flake update
  pnpm update --latest

post title:
  #!/usr/bin/env bash
  set -euo pipefail
  slug="$(echo "{{ title }}" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"
  cat <<EOF > ./src/blog/"$slug".md
  ---
  title: "{{ title }}"
  date: $(date '+%F')
  ---
  EOF

