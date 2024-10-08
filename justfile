_default:
    @just --list --unsorted

start-slides:
  cd "./slides" && pnpm run dev
