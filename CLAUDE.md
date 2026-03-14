# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Superpowers skill** for guiding users through interactive Neovim configuration from scratch. It is not a runnable application — there are no build/lint/test commands to run. The "code" is the skill prompt and its reference documents.

## Repository Structure

```
nvim-setup/
├── SKILL.md                    # The skill definition — the primary artifact
├── references/
│   ├── plugins.md              # Lazy.nvim specs and configs for all 17 modules
│   ├── keybindings.md          # Keybinding options and explanations
│   └── config-template.md      # File structure templates for generated output
└── evals/
    └── evals.json              # Eval prompts and expected outputs
```

## Skill Architecture

The skill in `nvim-setup/SKILL.md` orchestrates a 5-phase interactive conversation:

1. **Phase 1** — Detect experience level (newbie vs expert), adapt explanation depth accordingly
2. **Phase 2** — Auto-check prerequisites (runs `nvim --version`, `git --version`, `uname`); scan for existing config and offer to add/update/start-fresh
3. **Phase 3** — Walk through 17 optional modules in order using `AskUserQuestion` for all choices; skip already-configured modules when updating; track keybinding registry and warn on conflicts
4. **Phase 4** — Summarize and allow keybinding customization
5. **Phase 5** — Generate complete Lua config files at `~/.config/nvim/`; never overwrite files the user chose to keep

The skill reads three reference files during execution:
- `references/plugins.md` — lazy.nvim plugin specs with ready-to-paste Lua code
- `references/keybindings.md` — keybinding defaults and customization options
- `references/config-template.md` — `init.lua` and `lua/config/*.lua` file templates

## Eval System

Eval prompts live in `nvim-setup/evals/evals.json`. When running evals, create a workspace directory (e.g., `nvim-setup-workspace/iteration-N/`) with one subdirectory per eval. Each eval directory contains `eval_metadata.json` (assertions) plus `with_skill/outputs/` and `without_skill/outputs/`.

## Key Conventions

- The skill defaults to **English**; switches to Chinese only if the user writes in Chinese
- Newbie mode: explain each module before asking; Expert mode: list-style, minimal explanation
- Generated configs go under `lua/config/plugins/` — one file per plugin group
- Only generate files for modules the user chose — never include unchosen plugins
- `lua_ls` is always included in LSP configs (needed for editing the Neovim config itself)
- Comments in generated configs match the conversation language; omit for experts unless asked
