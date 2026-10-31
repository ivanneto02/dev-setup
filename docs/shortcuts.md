# Configured shortcuts

## Scope and evidence

This guide describes the **repository configuration**, not the live machine.
Inspected the main Neovim and Ghostty configuration and Neovim plugin lockfile.
No application configuration was activated and no plugins were installed for
this guide. Ghostty mappings have a local syntax check, not an interactive test;
**the shortcuts in this table have not been exercised end to end here.**

The mobile Neovim alternative, archival Kitty and tmux, shell shortcuts, and Pi bindings are out
of scope. This is not an exhaustive list of application/plugin defaults.
Herdr is installed with a **live user-only `F12` prefix override**, recorded in
[Herdr setup](herdr-setup.md#shortcut-ownership). It is not a repository-managed
mapping; the owner verified physical F12 delivery to Herdr. Ghostty's live
`Ctrl+b` bindings were left unchanged.

Source abbreviations used in the tables (line numbers refer to these files):

- **N**: [`config/nvim/init.lua`](../config/nvim/init.lua)
- **G**: [`config/ghostty/config`](../config/ghostty/config)
- Plugin revisions: [`config/nvim/lazy-lock.json`](../config/nvim/lazy-lock.json).

Verification labels:

- **C**: explicitly configured; inspected statically, not tested at runtime.
- **P**: plugin-generated behavior checked against the locked upstream source;
  still dependent on successful plugin loading.

## Reading the keys

- **Leader is backslash (`\`), not Space**; local leader is also backslash
  (N:1–4). Thus `\sf` means press backslash, then `s`, then `f`.
  `\\` means two backslashes. Uppercase letters matter: `\D` differs from `\d`.
- `Ctrl+h` is one chord. `Ctrl+b → h` is a chord followed by a separate key.
  Ghostty writes the latter as `ctrl+b>h`.
- Neovim modes: Normal, Insert, Visual, Select, operator-pending (waiting for a
  motion after an operator), and Terminal-input are distinct contexts.
- `Esc → Esc` means two successive Escape presses, not a chord.
- `{motion}`, `{object}`, and `{surrounding}` below are placeholders, not literal
  text to type.

## Neovim: everyday navigation

| Application / context | Key | Action | Source | Status |
| --- | --- | --- | --- | --- |
| Neovim / Normal | `Esc` | Clear search highlighting | N:93 | C |
| Neovim / Normal, Insert | `Ctrl+Delete` | Delete the word ahead of the cursor | N:1073–1074 | C |
| Neovim / Insert | `Ctrl+Backspace` | Delete the word before the cursor (`Ctrl+W` behavior); requires Ghostty's distinct key sequence | N:1075; G:45 | C |
| Neovim / Normal | `\q` | Populate/open diagnostics in the **location list** (despite the mapping description saying “Quickfix”) | N:96 | C |
| Neovim / Terminal-input | `Esc → Esc` | Leave terminal input mode via `Ctrl+\`, `Ctrl+n`; does not stop the shell | N:104 | C |
| Neovim / Normal | `Ctrl+h` / `Ctrl+j` / `Ctrl+k` / `Ctrl+l` | Focus left / lower / upper / right editor window | N:116–119 | C |
| Neovim / Normal, Visual, Select, operator-pending (`mode = ""`) | `\f` | Request asynchronous Conform formatting with LSP fallback; selection behavior depends on the invoking mode | N:739–752 | C |

Formatting requires an available formatter or capable LSP. Lua explicitly uses
Stylua (N:770–771). Save-time formatting is also configured (N:754–769), not a
shortcut. Despite the nearby comment, `c = false, cpp = false` does **not** disable
LSP fallback for those filetypes.

Which-key is configured to show pending-key help with zero plugin delay
(N:252–259); the mapping timeout is separately 300 ms (N:66–67). Its group labels
(N:297–305) are descriptions, not extra commands. In particular, the Git Hunk
label does not prove there are `\h…` bindings.

## Neovim: search and files

These mappings depend on Telescope loading successfully. The main declaration
loads on `VimEnter` (N:318–320); extension setup also occurs in separate plugin
callbacks (N:428–487).

| Application / context | Key | Action | Source | Status |
| --- | --- | --- | --- | --- |
| Neovim / Normal | `\sh` | Search help tags | N:391 | C |
| Neovim / Normal | `\sk` | Search keymaps | N:392 | C |
| Neovim / Normal | `\sf` | Find files | N:393 | C |
| Neovim / Normal | `\ss` | Choose a Telescope builtin picker | N:394 | C |
| Neovim / Normal | `\sw` | Search for the word under the cursor | N:395 | C |
| Neovim / Normal | `\sg` | Live grep | N:396 | C |
| Neovim / Normal | `\sd` | Search diagnostics | N:397 | C |
| Neovim / Normal | `\sr` | Resume previous picker | N:398 | C |
| Neovim / Normal | `\s.` | Recent files | N:399 | C |
| Neovim / Normal | `\\` | Find existing buffers | N:400 | C |
| Neovim / Normal | `\cs` | Choose a colorscheme | N:402 | C |
| Neovim / Normal | `\/` | Fuzzy-search current buffer in a dropdown without preview | N:405–411 | C |
| Neovim / Normal | `\s/` | Live grep restricted to open files | N:415–420 | C |
| Neovim / Normal | `\sn` | Find files under Neovim's runtime `stdpath("config")`, not necessarily this repository | N:423–425 | C |
| Neovim / Normal | `\fb` | Open file browser at the current file's directory | N:477–485 | C |
| Telescope picker / Insert | `Ctrl+/` (also encoded as `Ctrl+_`) | Show picker key help | N:353–358; [Telescope source][telescope-maps]:160–161 | P |
| Telescope picker / Normal | `?` | Show picker key help | N:353–358; [Telescope source][telescope-maps]:198 | P |

The file browser enables `hijack_netrw`, but supplies empty Insert and Normal
mapping override tables (N:457–471). Its internal action keys are inherited
plugin defaults and are not enumerated here. Likewise, media-files setup does
not define a dedicated keybinding. Search tools, extension availability, and
multiple Telescope setup callbacks still need runtime validation.

## Neovim: language-server actions

The helper at N:558–561 defaults to Normal mode and makes these bindings
**buffer-local**, inside `LspAttach` (N:549–552). No attached server means these
callbacks have not installed the bindings; individual actions also need server
support. The configured servers include clangd, pyright and lua_ls
(N:672–703), with typescript-tools separately declared at N:1018–1022.

| Application / context | Key | Action | Source | Status |
| --- | --- | --- | --- | --- |
| Neovim / LSP buffer, Normal | `gd` | Definitions through Telescope | N:566 | C |
| Neovim / LSP buffer, Normal | `gr` | References through Telescope | N:569 | C |
| Neovim / LSP buffer, Normal | `gI` | Implementations through Telescope | N:573 | C |
| Neovim / LSP buffer, Normal | `\D` | Type definitions through Telescope | N:578 | C |
| Neovim / LSP buffer, Normal | `\ds` | Document symbols | N:582 | C |
| Neovim / LSP buffer, Normal | `\ws` | Dynamic workspace symbols | N:586–590 | C |
| Neovim / LSP buffer, Normal | `\rn` | Rename symbol | N:594 | C |
| Neovim / LSP buffer, Normal or Visual | `\ca` | Code action | N:598 | C |
| Neovim / LSP buffer, Normal | `gD` | Declaration (not definition) | N:602 | C |
| Neovim / LSP buffer, Normal; server supports inlay hints | `\th` | Toggle inlay hints | N:638–642 | C |

## Neovim: comments

Comment.nvim enables both basic and extra mappings (N:238–242).
**Important:** the same keys are assigned to `toggler` and `opleader`. At the
locked revision, the plugin registers Normal-mode operators first and togglers
second, so the togglers overwrite those operators. Do not treat `\cl{motion}`
or `\cbl{motion}` as working comment operators in this configuration.
This conclusion comes from [Comment.nvim setup source][comment-setup], not a
runtime experiment.

| Application / context | Key | Effective/intended action | Source | Status |
| --- | --- | --- | --- | --- |
| Neovim / Normal | `\cl` | Toggle current line comment (count-aware); replaces same-key operator | N:214–225; Comment setup | P |
| Neovim / Normal | `\cbl` | Toggle current block comment (count-aware); replaces same-key operator | N:214–225; Comment setup | P |
| Neovim / Visual | `\cl` | Toggle line comments on selection | N:221–225; Comment setup | P |
| Neovim / Visual | `\cbl` | Toggle block comment on selection | N:221–225; Comment setup | P |
| Neovim / Normal | `\cal` | Insert comment above; see LSP prefix overlap below | N:230 | C |
| Neovim / Normal | `\cul` | Insert comment below | N:232 | C |
| Neovim / Normal | `\cel` | Insert comment at end of line | N:234 | C |

The configuration's comments mentioning `gcc`, `gbc`, `gco`, etc. are generic
plugin documentation, not its selected bindings. Any same-named Neovim builtin
behavior is outside this inventory.

## Neovim: completion and snippets

nvim-cmp loads on `InsertEnter` (N:791–792). The explicit bindings below override
parts of its Insert preset. The preset also contributes Up, Down and Ctrl+e,
confirmed against the locked [mapping source][cmp-maps]:36–70.

| Application / context | Key | Action | Source | Status |
| --- | --- | --- | --- | --- |
| Neovim completion / Insert | `Ctrl+n` / `Ctrl+p` | Select next / previous item | N:846–848 | C |
| Neovim completion / Insert | `Ctrl+b` / `Ctrl+f` | Scroll documentation up / down four lines | N:851–852 | C |
| Neovim completion / Insert | `Ctrl+y` | Confirm completion, selecting an item if necessary | N:857 | C |
| Neovim completion / Insert | `Ctrl+Space` | Trigger completion | N:868 | C |
| Neovim snippets / Insert or Select | `Ctrl+l` | Expand or jump forward if locally available | N:878–882 | C |
| Neovim snippets / Insert or Select | `Ctrl+h` | Jump backward if locally available | N:883–887 | C |
| Neovim completion / Insert | `Down` / `Up` | Select next / previous item via preset | N:844; cmp source:38–43 | P |
| Neovim completion / Insert | `Ctrl+e` | Abort completion via preset | N:844; cmp source:67–69 | P |

The snippet callbacks do not invoke a fallback when their condition is false.
The Enter/Tab/Shift+Tab examples are commented out (N:859–863); they are **not**
configured completion acceptance/navigation bindings. Friendly-snippets loading
is also commented out (N:810–815), so do not assume that collection is available.

## Neovim: inherited mini.nvim bindings

The configuration enables mini.ai (500-line search neighborhood) and
mini.surround with default mappings (N:948,955). These are plugin defaults checked
at the lockfile revision, not mappings written explicitly in this repository.

| Application / context | Key | Action | Source | Status |
| --- | --- | --- | --- | --- |
| Neovim / Visual or operator-pending | `a{object}` / `i{object}` | Around / inside text object | N:948; [mini.ai source][mini-ai]:549–560 | P |
| Neovim / Visual or operator-pending | `an` / `in` + object | Around / inside next object | N:948; mini.ai:557–558 | P |
| Neovim / Visual or operator-pending | `al` / `il` + object | Around / inside previous object | N:948; mini.ai:559–560 | P |
| Neovim / Normal or Visual | `sa` | Add surrounding: Normal expects a motion then surrounding; Visual uses selection | N:955; [mini.surround source][mini-surround]:682–688 | P |
| Neovim / Normal | `sd{surrounding}` | Delete surrounding | N:955; mini.surround:684 | P |
| Neovim / Normal | `sr` + old/new surrounding | Replace surrounding | N:955; mini.surround:688 | P |
| Neovim / Normal | `sf` / `sF` + surrounding | Find surrounding right / left | N:955; mini.surround:685–686 | P |
| Neovim / Normal | `sh{surrounding}` | Highlight surrounding | N:955; mini.surround:687 | P |

Examples already present in N:945–954 include `va)`, `yinq`, `ci'`, `saiw)`,
`sd'`, and `sr)'`. This table is not a full mini.nvim reference: mini.ai also
supplies edge-navigation mappings and mini.surround supplies search suffixes;
consult the pinned sources for the full grammar and text-object definitions.

## Ghostty: tabs and splits

These are terminal-level sequences, not Neovim mappings. The table records the
configured action names. Ghostty 1.4.0-arch1 accepts the repository file with
`+validate-config --config-file`; actual key delivery remains untested.

| Application / context | Key | Configured action | Source | Status |
| --- | --- | --- | --- | --- |
| Ghostty / focused terminal | `Ctrl+b → c` | New tab (`new_tab`) | G:26 | C |
| Ghostty / focused terminal | `Ctrl+b → n` / `p` | Next / previous tab | G:27–28 | C |
| Ghostty / focused terminal | `Ctrl+b → 0` … `5` | Go to tabs 1 … 6 respectively (`goto_tab:1` … `:6`) | G:31–36 | C |
| Ghostty / focused terminal | `Ctrl+b → h` / `j` / `k` / `l` | Focus split left / down / up / right | G:39–42 | C |
| Ghostty / focused terminal | `Ctrl+b → v` | New split **down** | G:45 | C |
| Ghostty / focused terminal | `Ctrl+b → s` | New split **right** | G:46 | C |
| Ghostty / focused terminal | `Ctrl+b → x` | Close current surface (`close_surface`) | G:49 | C |
| Ghostty / focused terminal | `Ctrl+b → z` | Toggle split zoom | G:51 | C |

The duplicate navigation quartet was removed without changing its configured
actions. Digits are deliberately offset:
`0` targets tab 1. Use the configured directions for `v` and `s`, rather than
assuming their names imply a particular split direction. Header comments about
Ghostty's default reload shortcut are not an explicit binding or verified here.

## Terminal ownership

Ghostty alone is supported. It owns tabs and splits, while Herdr owns persistent
workspaces. tmux and Kitty remain archival and are not deployment choices. The
tmux import retains its default-prefix assumptions and TPM invocation, but is
not a supported nested layer. See [terminal policy](terminal-policy.md).

## Conflicts and surprises to validate

| Interaction | Static finding | Runtime status / next check |
| --- | --- | --- |
| Ghostty vs Herdr | Herdr defaults to `Ctrl+b`, but the live user config overrides its prefix to `F12`; Ghostty retains `Ctrl+b`. | Herdr config parsed and reloaded; owner confirmed physical F12 delivery. Nested actions remain untested. See [Herdr setup](herdr-setup.md). |
| Ghostty vs archival tmux | Both would use `Ctrl+b → h/j/k/l` if tmux retained its default prefix. Ghostty is the outer input layer. | Nested tmux is unsupported; interception is not runtime-tested. |
| Ghostty vs completion | `Ctrl+b` is also Neovim completion documentation-scroll. Ghostty may prevent it reaching Neovim. | Test in a completion menu with documentation visible in Ghostty and Herdr. Do not change bindings preemptively. |
| Comment operator vs toggler | Normal-mode `\cl` and `\cbl` are overwritten by togglers in the locked plugin setup order. | Source-confirmed collision; inspect effective Normal and Visual mappings after plugin load. |
| LSP vs comment insertion | Buffer-local `\ca` is a prefix of global `\cal`. | Potential masking/timeout interaction; compare LSP-attached and unattached buffers before declaring both usable. |
| Format vs file browser | `\f` is a complete mapping and a prefix of `\fb`. | Potential delay or premature formatting with the 300 ms timeout; test both after lazy loading. |
| Window movement vs snippets | `Ctrl+h/l` navigate windows in Normal, but snippets in Insert/Select. | Intentional mode split, not an exact same-mode collision. Terminal Backspace/Ctrl+h encoding also needs checking. |
| mini.nvim vs Telescope | `sf`, `sd`, `sh`, `sr` are not `\sf`, `\sd`, `\sh`, `\sr`. | Different sequences; do not confuse bare `s` with leader-prefixed search. |
| Terminal exit and timing | Double-Escape mapping and Neovim timeout depend on terminal key delivery. | Test entering/leaving a Neovim terminal in Ghostty and Herdr. |

## Validation gaps and safe next checks

To refresh this guide after a config or plugin-lock change, ask Pi to read
`agents/skills/explain-config/SKILL.md`, compare the changed sources with these
tables, and update source lines and verification labels. Do not turn static
inspection into a runtime claim without a separately authorized application test.
The tmux/Kitty imports remain archival, so do not re-add them as supported
shortcuts unless terminal policy changes.

1. First decide the target profile and confirm which configuration paths are
   actually loaded. No live installation is implied by files being in Git.
2. In a separately authorized, isolated runtime test, inspect effective mappings
   using `:verbose nmap <leader>cl`, `:verbose xmap <leader>cl`,
   `:verbose nmap <leader>ca`, `:verbose nmap <leader>cal`,
   `:verbose nmap <leader>f`, and `:verbose imap <C-b>`. Repeat before/after an LSP
   attaches and after lazy-loaded plugins activate. `\sk` is the configured
   discovery shortcut once Telescope is working.
3. Confirm terminal delivery of `Ctrl+Space`, `Ctrl+/`, `Ctrl+h`, Escape, the
   `Ctrl+b` sequences, and Herdr's live `F12` prefix. Test Ghostty alone, then
   Ghostty with Herdr and Neovim. Check tab navigation, creation, split focus,
   creation, close and zoom. No nested GUI test was run for this guide.
4. Confirm clipboard provider, LSP/formatter availability and Telescope search
   dependencies separately. N:34–36 requests the system clipboard, but this
   does not verify copy/paste functionality on the target OS.

No extra custom plugin files are imported: the `custom.plugins` import and
Kickstart extension requires are commented out (N:1033–1044). Gitsigns is
configured for signs without custom hunk bindings (N:174–185). Treesitter
highlighting/indentation does not establish incremental-selection shortcuts.
Plugin UI/default mappings beyond those explicitly checked above remain outside
this inventory. Some inherited comments still mention Space leader (N:1048–1049);
the executable leader assignment at N:3 is authoritative.

### Pinned upstream evidence

The following source files were read at the revisions in the lockfile, rather
than assuming current plugin defaults. Source inspection is not a runtime test.

- [Comment.nvim setup][comment-setup]: `e30b7f2008e52442154b66f7c519bfd2f1e32acb`.
- [nvim-cmp Insert preset][cmp-maps]: `b5311ab3ed9c846b585c0c15b7559be131ec4be9`.
- [mini.ai][mini-ai] and [mini.surround][mini-surround]: `fbb6ad02871d296fc7d3ebd453e1be89b1210f68`.
- [Telescope picker mappings][telescope-maps]: `a0bbec21143c7bc5f8bb02e0005fa0b982edc026`.

[comment-setup]: https://github.com/numToStr/Comment.nvim/blob/e30b7f2008e52442154b66f7c519bfd2f1e32acb/lua/Comment/init.lua
[cmp-maps]: https://github.com/hrsh7th/nvim-cmp/blob/b5311ab3ed9c846b585c0c15b7559be131ec4be9/lua/cmp/config/mapping.lua
[mini-ai]: https://github.com/echasnovski/mini.nvim/blob/fbb6ad02871d296fc7d3ebd453e1be89b1210f68/lua/mini/ai.lua
[mini-surround]: https://github.com/echasnovski/mini.nvim/blob/fbb6ad02871d296fc7d3ebd453e1be89b1210f68/lua/mini/surround.lua
[telescope-maps]: https://github.com/nvim-telescope/telescope.nvim/blob/a0bbec21143c7bc5f8bb02e0005fa0b982edc026/lua/telescope/mappings.lua
