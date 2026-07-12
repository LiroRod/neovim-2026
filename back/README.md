# Neovim Config

My Neovim setup with all the nyoom.nvim features and LazyVim keybindings, built from scratch.

## What's in here

### Core stuff
- lazy.nvim for plugin management
- Oxocarbon colorscheme (from nyoom.nvim)
- LSP support with Mason (20+ language servers)
- nvim-cmp + LuaSnip for completion
- Treesitter for syntax highlighting
- Git integration (Neogit, Diffview, Gitsigns)
- Neo-tree file explorer
- Telescope for fuzzy finding
- Full DAP debugging setup
- Toggleterm for terminal stuff

### Languages
TypeScript, JavaScript, Rust, Go, Python, Java, Kotlin, Lua, C/C++, Zig, OCaml, Clojure, Julia, Nim, LaTeX, Markdown, Nix, and more.

### UI
- Bufferline with underline indicators
- Lualine statusline
- Noice for better UI messages
- Indent guides and git decorations
- Zen mode when you need focus

### Editor stuff
- nvim-ufo for folding
- conform.nvim for auto-formatting
- Auto-pairs and smart delimiters
- Multiple cursors
- Surround operations
- Comment toggling
- Leap and Flit for motion
- Session and project management
- Spectre for search/replace

## Requirements

You'll need:
- Neovim >= 0.9.0 (0.10+ recommended)
- Git >= 2.19.0
- Ripgrep >= 11.0
- Node.js >= 18.0 (for some LSPs)
- A Nerd Font
- Terminal with true color support

Nice to have:
- fd (better file finding)
- lazygit (git TUI)
- Python 3 with pip
- npm

## Installation

### Backup your old config first

```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### Install dependencies

macOS:
```bash
brew install neovim ripgrep fd lazygit node
```

Ubuntu/Debian:
```bash
sudo apt update
sudo apt install neovim ripgrep fd-find nodejs npm
```

Arch:
```bash
sudo pacman -S neovim ripgrep fd lazygit nodejs npm
```

### Get a Nerd Font

Grab one from [nerdfonts.com](https://www.nerdfonts.com/). I like JetBrains Mono, Fira Code, or Hack. Set it in your terminal.

### First launch

```bash
nvim
```

lazy.nvim will auto-install everything. Wait a bit, you might see some errors on first launch (normal).

Then install Treesitter parsers:
```vim
:TSInstall all
```

And check out Mason for LSP servers:
```vim
:Mason
```

Optionally install providers:
```bash
npm install -g neovim
pip3 install neovim
```

Run `:checkhealth` to see if everything's working.

## Keybindings

Leader: `Space`
Local leader: `,`

### Files
- `<leader><space>` - Find files
- `<leader>/` - Search in files
- `<leader>ff` - Find files
- `<leader>fr` - Recent files
- `<leader>e` - File explorer

### Windows
- `<C-h/j/k/l>` - Navigate
- `<C-Up/Down/Left/Right>` - Resize
- `<leader>-` - Split below
- `<leader>|` - Split right

### Buffers
- `<S-h>` / `<S-l>` - Previous/Next
- `[b` / `]b` - Previous/Next
- `<leader>bd` - Delete buffer

### Git
- `<leader>gg` - Neogit
- `<leader>gc` - Commit
- `<leader>gd` - Diff
- `<leader>gb` - Blame
- `]h` / `[h` - Next/Prev hunk

### LSP
- `gd` - Go to definition
- `gr` - References
- `K` - Hover docs
- `<leader>ca` - Code actions
- `<leader>cr` - Rename
- `<leader>cf` - Format

### Search
- `<leader>sa` - Autocommands
- `<leader>sc` - Commands
- `<leader>sd` - Diagnostics
- `<leader>sh` - Help
- `<leader>sr` - Search/replace (Spectre)

### Diagnostics
- `]d` / `[d` - Next/Prev diagnostic
- `]e` / `[e` - Next/Prev error
- `<leader>cd` - Line diagnostics

### Terminal
- `<C-/>` - Toggle terminal
- `<leader>ft` - Open terminal

### Debug
- `<leader>db` - Breakpoint
- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step out

### Other
- `s` / `S` - Leap forward/backward
- `<leader>l` - Lazy
- `<C-s>` - Save
- `<leader>uz` - Zen mode

Press `<leader>` and wait to see all keybindings with which-key.

## Config structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── config/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── autocmds.lua
│   └── plugins/
│       ├── coding.lua
│       ├── completion.lua
│       ├── dap.lua
│       ├── editor.lua
│       ├── extras.lua
│       ├── git.lua
│       ├── lsp.lua
│       ├── snacks.lua
│       ├── telescope.lua
│       ├── terminal.lua
│       ├── treesitter.lua
│       ├── ui.lua
│       └── which-key.lua
└── README.md
```

## Troubleshooting

**Plugins not installing?**
Run `:Lazy clear` then `:Lazy sync`

**LSP not working?**
Check `:Mason` and `:LspInfo`

**Treesitter errors?**
Run `:TSUpdate` or `:TSInstall all`

**Icons broken?**
Make sure you're using a Nerd Font in your terminal

**Slow startup?**
Check `nvim --startuptime startup.log`

**Colors look off?**
Make sure your terminal supports true colors. Try `export TERM=xterm-256color`

## Customization

### Add plugins
Create a file in `lua/plugins/`:

```lua
return {
  {
    "username/plugin-name",
    event = "VeryLazy",
    opts = {},
  },
}
```

### Change colorscheme
Edit `lua/plugins/ui.lua`

### Modify keybindings
Edit `lua/config/keymaps.lua` or the plugin files

### Add LSP servers
Edit `lua/plugins/lsp.lua` and add to `ensure_installed`

## Credits

Inspired by [nyoom.nvim](https://github.com/nyoom-engineering/nyoom.nvim) and [LazyVim](https://github.com/LazyVim/LazyVim).

## License

Use it however you want.
