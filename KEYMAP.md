# Keymap Reference fo Neovim

> Leader key: `<Space>`

---

## General

| Key | Action |
|---|---|
| `<Esc>` | Clear search highlights |
| `<leader>q` | Open diagnostic quickfix list |
| `K` (hover) | Show hover documentation (LSP) |
| `[d` / `]d` | Previous / next diagnostic |

## Window Navigation

| Key | Action |
|---|---|
| `<C-h>` | Focus window left |
| `<C-j>` | Focus window down |
| `<C-k>` | Focus window up |
| `<C-l>` | Focus window right |

## Terminal

| Key | Action |
|---|---|
| `<Esc><Esc>` | Exit terminal mode |

---

## File Explorer (Neo-tree)

| Key | Action |
|---|---|
| `<C-b>` | Toggle file explorer |
| `<leader>e` | Focus file explorer |
| `<leader>E` | Reveal current file in explorer |

**Neo-tree window** (when focused):

| Key | Action |
|---|---|
| `<CR>` / `l` | Open file / expand folder |
| `h` | Collapse folder |
| `v` | Open in vertical split |
| `s` | Open in horizontal split |
| `t` | Open in new tab |
| `a` | Add file/folder |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `q` | Close neo-tree |
| `R` | Refresh |
| `?` | Help |

---

## Buffer Tabs (Bufferline)

| Key | Action |
|---|---|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<A-1>` .. `<A-5>` | Go to buffer 1-5 |
| `<leader>x` | Close buffer |
| `<leader>X` | Force close buffer |
| `<leader>bp` | Pick buffer from list |

---

## Search (Telescope)

| Key | Action |
|---|---|
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sf` | Find files |
| `<leader>ss` | Select telescope picker |
| `<leader>sw` | Search word under cursor |
| `<leader>sg` | Live grep |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sc` | Search commands |
| `<leader>sn` | Search Neovim config files |
| `<leader>s/` | Grep in open files |
| `<leader>/` | Fuzzy find in current buffer |
| `<leader><leader>` | Find existing buffers |

---

## LSP

| Key | Action |
|---|---|
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grn` | Rename symbol |
| `gra` | Code action (normal/visual) |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

---

## Formatting

| Key | Action |
|---|---|
| `<leader>f` | Format buffer |

---

## Git (Neogit & Gitsigns)

| Key | Action |
|---|---|
| `<leader>gg` | Open git panel |
| `<leader>g<CR>` | Git commit |
| `<leader>gm` | AI generate commit message |
| `<leader>gL` | Git log |
| `<leader>gP` | Git pull |
| `<leader>gU` | Git push |
| `<leader>gB` | Git branches |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Unstage hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hr` | Reset hunk (discard changes) |
| `<leader>hR` | Reset buffer (discard all) |
| `<leader>hp` | Preview hunk diff |
| `<leader>hd` | Diff against index |
| `]c` / `[c` | Jump next/prev change |

**In AI commit popup:**

| Key | Action |
|---|---|
| `<leader>w` | Commit with message |
| `:q` | Cancel |

---

## GitHub (Octo)

| Key | Action |
|---|---|
| `<leader>gii` | My issues |
| `<leader>gir` | Repo issues |
| `<leader>gip` | My pull requests |
| `<leader>gia` | Repo pull requests |
| `<leader>gRv` | Review PR |
| `<leader>gic` | Create PR |
| `<leader>gim` | Merge PR |
| `<leader>gin` | Notifications |
| `<leader>gis` | Search GitHub |
| `<leader>gig` | Gists |

---

## Debugging (DAP)

| Key | Action |
|---|---|
| `<leader>dB` | Toggle breakpoint |
| `<leader>dC` | Set conditional breakpoint |
| `<leader>dc` | Continue / start debug |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | DAP terminal |
| `<leader>dl` | Re-run last debug session |
| `<leader>dh` | Evaluate under cursor |
| Visual `<leader>dh` | Evaluate selection |

### Supported Languages

| Language | Adapter |
|---|---|
| Go | `delve` (via `nvim-dap-go`) |
| JavaScript / TypeScript | `js-debug-adapter` (via `nvim-dap-vscode-js`) |
| C / C++ / Rust | `codelldb` |
| Lua | `one-small-step-for-vimkind` |

---

## Text Objects (mini.ai)

| Key | Action |
|---|---|
| `va)` | Visual select around parentheses |
| `yinq` | Yank inside next quote |
| `ci'` | Change inside single quotes |

## Surround (mini.surround)

| Key | Action |
|---|---|
| `saiw)` | Surround inner word with parentheses |
| `sd'` | Delete surrounding single quotes |
| `sr)'` | Replace surrounding parentheses with single quotes |

---

## Mason

| Key | Action |
|---|---|
| `:Mason` | Open Mason (LSP/formatter/linter installer) |
| `:MasonInstall <pkg>` | Install a tool |
| `:MasonUninstall <pkg>` | Uninstall a tool |

## Lazy

| Key | Action |
|---|---|
| `:Lazy` | Open Lazy plugin manager |
| `:Lazy sync` | Install/update all plugins |
| `:Lazy update` | Update all plugins |
| `:Lazy clean` | Remove unused plugins |
