local M = {}

M.ui = {
   theme = "tokyonight",
   hl_override = {
     Folded = { bg = '#16161e'},
     FoldColumn = { bg = '#1a1b26', fg = '#f7768e'}

   }
}

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
  user = require "custom.plugins"
}

M.mappings = require "custom.mappings"

--[[M.options = {
  user = function()
    vim.cmd([[
    set showmatch
    set ignorecase
    set hlsearch
    set incsearch
    set tabstop=4 
    set softtabstop=4 
    set expandtab=true
    set autoindent=true
    set number=true
    set cc=80
    set cursorline=true
    set ttyfast=true
    set spell=false
    set foldlevel=0
    set foldnestmax=3 
    set foldenable
    set foldcolumn=5
    )
  end
}
--]]


-- vim.cmd([[
-- set wildmode=longest,list
-- set mouse=v
-- set clipboard=unnamedplus
-- ]])
--
return M
