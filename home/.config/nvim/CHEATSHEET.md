# Neovim Cheat Sheet — New Stuff

## mini.surround (prefix: `z`)
Replaces default `s` (use Flash for `s` jumps).

| Keys      | Action                                |
| --------- | ------------------------------------- |
| `zaiw)`   | Add `()` around inner word            |
| `zaiw"`   | Add `""` around inner word            |
| `za` (x)  | Add surround around visual selection  |
| `zd'`     | Delete surrounding `'`                |
| `zr)'`    | Replace `()` with `''`                |
| `zf` / `zF` | Find next / prev surround           |
| `zh`      | Highlight surround                    |
| `zn`      | Update n_lines search range           |

Suffix `n` / `l` = next / last (e.g. `zdn)` deletes the next `()`).

## mini.ai — text objects
Used with `v`, `d`, `c`, `y`, etc. `a` = around, `i` = inside.

| Object | Meaning                |
| ------ | ---------------------- |
| `)` `]` `}` `>` | brackets       |
| `'` `"` `` ` `` | quotes         |
| `t`    | HTML/XML tag           |
| `f`    | function call          |
| `a`    | argument (mini.ai)     |
| `?`    | prompt for custom      |

Modifiers: `n` = next, `l` = last → `vinq` = visually select inside next quote, `dilp` = delete inside last paren-pair.

## Treesitter text objects
| Keys      | Object                |
| --------- | --------------------- |
| `af`/`if` | function outer/inner  |
| `ac`/`ic` | class outer/inner     |
| `aa`/`ia` | parameter outer/inner |

Movement (jumps recorded):
| Keys | Where                    |
| ---- | ------------------------ |
| `]f` `[f` | next/prev function   |
| `]c` `[c` | next/prev class      |
| `]a` `[a` | next/prev parameter  |

Swap:
| Keys             | Action            |
| ---------------- | ----------------- |
| `<leader>na`     | swap arg with next    |
| `<leader>pa`     | swap arg with prev    |
| `<leader>nf` / `pf` | swap function     |

## mini.splitjoin
- `gS` — toggle split/join the list/args under cursor.

## Flash
| Keys | Mode | Action                       |
| ---- | ---- | ---------------------------- |
| `s`  | n/x/o | jump (2-char + label)       |
| `S`  | n/x/o | treesitter node select      |
| `r`  | o     | remote flash (operate at distance) |
| `R`  | o/x   | treesitter search           |
| `<C-s>` | cmdline | toggle flash in `/`     |

## Telescope (`<leader>s…`)
| Keys                 | Picker                          |
| -------------------- | ------------------------------- |
| `<leader><leader>`   | find files                      |
| `<leader>/`          | fuzzy in current buffer         |
| `<leader>sg`         | live grep                       |
| `<leader>s/`         | live grep in open files         |
| `<leader>sw`         | grep word under cursor          |
| `<leader>sb`         | buffers                         |
| `<leader>s.`         | recent files                    |
| `<leader>sr`         | resume last picker              |
| `<leader>sd`         | diagnostics                     |
| `<leader>sh`         | help tags                       |
| `<leader>sk`         | keymaps                         |
| `<leader>ss`         | builtin pickers list            |
| `<leader>sn`         | search nvim config              |

Inside picker: `?` (normal) or `<C-/>` (insert) shows all mappings.

## Harpoon
| Keys           | Action            |
| -------------- | ----------------- |
| `<leader>a`    | add file          |
| `<leader>h`    | toggle menu       |
| `<leader>1..4` | jump to slot 1–4  |

## Yanky
| Keys       | Action                          |
| ---------- | ------------------------------- |
| `<leader>p` | yank history (Telescope)       |
| `]p` / `[p` | cycle ring after paste         |
| `gp` / `gP` | put + move cursor past paste   |

## Oil
- `-` — open parent dir as a buffer (edit it like text to rename/move/delete).

## Trouble (`<leader>x…`, `<leader>c…`)
| Keys          | View                          |
| ------------- | ----------------------------- |
| `<leader>xx`  | workspace diagnostics         |
| `<leader>xX`  | buffer diagnostics            |
| `<leader>cs`  | symbols (right side)          |
| `<leader>cl`  | LSP defs/refs                 |
| `<leader>xL`  | location list                 |
| `<leader>xQ`  | quickfix list                 |

## Window / split swaps
- `<C-S-h/j/k/l>` — swap buffer with adjacent split in that direction.

## Misc you might forget
- `;` → `:` (skip the shift in normal/visual).
- `<C-b>` → jump back (was `<C-o>`).
- `p` in visual mode → paste without clobbering yank register.
- `J`/`K` in visual mode → move selection down/up.
- Statusline shows **RECORDING @x** in red while a macro is recording.
