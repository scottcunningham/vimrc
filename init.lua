-- Neovim Lua Configuration
-- Based on your legacy .vimrc (translated)

-----------------------------------------------------------
-- General settings
-----------------------------------------------------------
vim.opt.compatible = false
vim.opt.grepprg = "ag --nogroup --nocolor"
vim.opt.history = 100
vim.opt.modeline = true
vim.opt.modelines = 1
vim.api.nvim_create_autocmd({"BufNewFile","BufRead","BufEnter"}, {
    pattern = "*.txt",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})

vim.g.mapleader = ','

-- Load Meta-specific config if available
local ok, meta_init = pcall(dofile, vim.fn.stdpath("config") .. "/init-meta.lua")
if not ok then meta_init = nil end

-----------------------------------------------------------
-- Colors
-----------------------------------------------------------
vim.opt.termguicolors = true      -- Enables 24-bit colors
vim.cmd("syntax enable")

-----------------------------------------------------------
-- Spaces & Tabs
-----------------------------------------------------------
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-----------------------------------------------------------
-- UI / Display
-----------------------------------------------------------
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.cmd('filetype plugin indent on')
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.title = true
vim.opt.visualbell = false
vim.opt.errorbells = false
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.encoding = "utf-8"
vim.opt.listchars = {tab = "› ", trail = "•", extends = "#", nbsp = "."}
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = true
vim.opt.wrapmargin = 0
vim.opt.mouse = ""        -- Disables mouse

-----------------------------------------------------------
-- Searching
-----------------------------------------------------------
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.foldmethod = "indent"
-- Map <space> in normal mode to toggle fold
vim.keymap.set('n', '<space>', 'za', { noremap=true })

-----------------------------------------------------------
-- Movement
-----------------------------------------------------------
-- Virtual line wrapping
vim.keymap.set('n', 'j', 'gj', { noremap=true })
vim.keymap.set('n', 'k', 'gk', { noremap=true })
-- No arrows
vim.keymap.set('', '<Up>', '<NOP>', { noremap=true })
vim.keymap.set('', '<Down>', '<NOP>', { noremap=true })
vim.keymap.set('', '<Left>', '<NOP>', { noremap=true })
vim.keymap.set('', '<Right>', '<NOP>', { noremap=true })

-----------------------------------------------------------
-- Misc Keybindings
-----------------------------------------------------------
vim.keymap.set('n', '<F2>', ':set invpaste paste?<CR>', { noremap=true })
vim.keymap.set('n', '<F3>', ':set invnumber number?<CR>', { noremap=true })

-----------------------------------------------------------
-- Filetype-specific settings
-----------------------------------------------------------
vim.g.python3_host_prog = '/usr/local/bin/python3'

-- Markdown: treat *.md and *.markdown as markdown filetype
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
    pattern = {"*.markdown", "*.md"},
    callback = function()
        vim.bo.filetype = "markdown"
    end
})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = {
        "*.py",
        "*.rs",
        "*.rb",
        "*.go",
    },
    callback = function()
        vim.lsp.buf.format()
    end
})

-----------------------------------------------------------
-- Plugin management (packer.nvim)
-----------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- do not remove packer on startup
  use 'wbthomason/packer.nvim'
  -- colourscheme
  use 'vague2k/vague.nvim'

  use 'ntpeters/vim-better-whitespace'
  use 'nvie/vim-flake8'
  use 'raimondi/delimitMate'
  use 'scrooloose/nerdtree'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-sensible'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'vim-scripts/PreserveNoEOL'
  use 'christoomey/vim-tmux-navigator'
  use 'averms/black-nvim'
  use 'junegunn/fzf'
  use 'junegunn/rainbow_parentheses.vim'
  use 'crispgm/nvim-go'

  use "nvim-lua/plenary.nvim"
  use 'neovim/nvim-lspconfig'
  use 'nvimtools/none-ls.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-telescope/telescope.nvim'
  use 'mfussenegger/nvim-dap'

  use 'folke/trouble.nvim'

  use {
    'olimorris/codecompanion.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  }

  if meta_init then meta_init.plugins(use) end
end)

require("trouble").setup()
vim.api.nvim_set_keymap("", "<leader>.", ":Trouble diagnostics toggle<CR>", {})

vim.cmd("colorscheme vague")

vim.cmd('set rtp+=~/.fzf')

require'go'.setup {
  auto_lint = false, -- shuold be covered by lsp
  formatter = 'gofmt',
}

vim.cmd("autocmd BufNewFile,BufRead */recipes/*.rb set ft=chef syntax=ruby")

require("nvim-treesitter.install").prefer_git = true
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.ruby.used_by = "chef"

if meta_init then meta_init.setup() end

local function setup_lsp_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = true,
      signs = true,
      update_in_insert = true,
      underline = true,
    }
  )
end
setup_lsp_diags()

-----------------------------------------------------------
-- Plugin configuration
-----------------------------------------------------------
-- Airline
vim.g.airline_powerline_fonts = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#left_sep"] = ' '
vim.g["airline#extensions#tabline#left_alt_sep"] = '|'
vim.g.airline_theme = 'powerlineish'

-- Ctrl-P (if used)
vim.g.ctrlp_user_command = 'ag %s -l --nocolor -g ""'
vim.g.ctrlp_switch_buffer = 0
vim.g.ctrlp_working_path = 0
vim.api.nvim_set_keymap('n', '<leader>/', ':CtrlPLine<CR>', { noremap = true })

-- Rainbow Parens
vim.api.nvim_create_autocmd("FileType", { pattern = "*", command = "RainbowParentheses" })
vim.g.rainbow_blacklist = {30, 40}
