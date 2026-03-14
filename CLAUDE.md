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

nvim-setup-workspace/
└── iteration-1/                # Eval run outputs for comparison
    ├── eval-1-python-newbie/   # Newbie, Python user
    ├── eval-2-ts-rust-expert/  # Expert, TypeScript + Rust user
    └── eval-3-newbie-no-lsp/   # Newbie who skips LSP, custom keybinding
        ├── eval_metadata.json  # Assertions for this eval (grep/file-existence checks)
        ├── with_skill/outputs/ # Config files generated when skill was used
        └── without_skill/outputs/ # Config files generated without skill (baseline)
```

## Skill Architecture

The skill in `nvim-setup/SKILL.md` orchestrates a 5-phase interactive conversation:

1. **Phase 1** — Detect experience level (newbie vs expert), adapt explanation depth accordingly
2. **Phase 2** — Check prerequisites (OS, Neovim version, Nerd Font)
3. **Phase 3** — Walk through 17 optional modules in order (Module 0 = base config always included, Module 1 = lazy.nvim always included, Modules 2–17 are opt-in)
4. **Phase 4** — Summarize and allow keybinding customization
5. **Phase 5** — Generate complete Lua config files at `~/.config/nvim/`

The skill reads three reference files during execution:
- `references/plugins.md` — lazy.nvim plugin specs with ready-to-paste Lua code
- `references/keybindings.md` — keybinding defaults and customization options
- `references/config-template.md` — `init.lua` and `lua/config/*.lua` file templates

## Eval System

Evals live in `nvim-setup-workspace/iteration-N/`. Each eval has:
- `eval_metadata.json` — the prompt plus shell-based assertions (grep/test commands run against output files)
- `with_skill/outputs/` — Lua config files generated using the skill
- `without_skill/outputs/` — baseline files generated without the skill

When adding a new eval or iteration, follow the same directory structure. Assertions use shell commands that check the generated output files directly.

## Key Conventions

- The skill is in **Chinese by default** (switches to English if user writes in English)
- Newbie mode: explain each module before asking; Expert mode: list-style, minimal explanation
- Generated configs go under `lua/config/plugins/` — one file per plugin group
- Only generate files for modules the user chose — never include unchosen plugins
- `lua_ls` is always included in LSP configs (needed for editing the Neovim config itself)
- Comments in generated configs: Chinese for newbies, omit for experts unless asked
