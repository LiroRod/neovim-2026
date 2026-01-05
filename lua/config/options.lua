local opt = vim.opt
local g = vim.g

-- Leaders (set early)
g.mapleader = " "
g.maplocalleader = ","

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.fillchars = { eob = " " } -- Hide ~ at end of buffer
opt.sidescrolloff = 8
opt.scrolloff = 4
opt.conceallevel = 2
opt.ruler = false
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 3 -- global statusline
opt.pumheight = 10 -- popup menu height
opt.pumblend = 10 -- popup transparency
opt.winminwidth = 5 -- minimum window width
opt.colorcolumn = ""

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
opt.linebreak = true -- wrap at word boundaries
opt.iskeyword:append("-")
opt.mouse = "a"
opt.virtualedit = "block" -- allow cursor beyond last char in visual block
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full" -- command-line completion mode

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.path:append("**")

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300
opt.timeout = true
opt.ttimeout = true
opt.lazyredraw = false
opt.synmaxcol = 200 -- max column for syntax highlight

-- Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Files & Buffers
opt.undofile = true
opt.undolevels = 10000
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.autowrite = true -- enable auto write
opt.autoread = true -- auto read file when changed outside vim
opt.hidden = true -- enable background buffers

-- Clipboard
opt.clipboard = "unnamedplus"

-- Spell
opt.spelllang = { "en" }
opt.spelloptions:append("noplainbuffer")

-- Folding (using nvim-ufo)
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldcolumn = "1"

-- Session
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Shorter messages
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Fix markdown indentation settings
g.markdown_recommended_style = 0
