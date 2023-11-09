set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let &shell='/bin/zsh -i'

set nocompatible
filetype off

filetype plugin indent on    " required

let g:python3_host_prog = '~/.pyenv/versions/3.10.9/bin/python3.10'

" Gdiff default to vertical split
set diffopt+=vertical

set nofixendofline

let g:vue_disable_pre_processors=1

" automatically strip trailing whitespace on .py and .js files
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.py :%s/\s\+$//e

syntax enable
set mouse=r
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab " 2 space tabs
set number              " line numbers
set ruler               " show column number
set showcmd             " show command in bottom bar"
set wildmenu            " visual autocomplete for command menu"
set ttyfast             " fast terminal connection
set lazyredraw          " redraw only when we need to."
set showmatch           " highlight matching [{()}]}]"
set belloff=all

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set laststatus=2
set termencoding=UTF-8
set encoding=UTF-8
set termguicolors

set clipboard=unnamed   " vim operations will work with mac clipboard

set exrc                " allow project specific vimrc files
set secure              " disable commands from being run from project specific vimrc files unless owned by me
set autoread            " autoreload a file when it changes on disk
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

let mapleader = ','
" turn off search highlight
nnoremap <Leader><Space> :nohlsearch<CR>
map <Leader><Space>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <Leader><Space>sh :!shipit<CR>

call plug#begin()
Plug 'tjdevries/colorbuddy.nvim'
Plug 'svrana/neosolarized.nvim'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/fuzzy.nvim'
Plug 'tzachar/cmp-fuzzy-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
Plug 'stevearc/conform.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'ryanoasis/vim-devicons'
call plug#end()

syntax enable
set background=dark

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'

au BufWritePost * lua require('lint').try_lint()

lua <<EOF
  require('gitsigns').setup()

  -- Set up mason
  require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
  })
  require("mason-lspconfig").setup({
    ensure_installed = {
      "tsserver",
      "html",
      "cssls",
      "cssmodules_ls",
      "graphql",
      "jsonls",
      "marksman",
      "intelephense",
      "pyright",
      "sqlls",
      "yamlls"
    },
    automatic_installation = true,
  })

  require("nvim-autopairs").setup({
    check_ts = true, -- enable treesitter
    ts_config = {
      lua = { "string" }, -- don't add pairs in lua string treesitter nodes
      javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
      java = false, -- don't check treesitter on java
    },
  })

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  -- Set up nvim-cmp.
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local luasnip = require("luasnip")
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
        -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  -- make autopairs and completion work together
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    })
  })

  -- Set up lspconfig.
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['tsserver'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['html'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['cssls'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['cssmodules_ls'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['graphql'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['jsonls'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['marksman'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['intelephense'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['pyright'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['sqlls'].setup({
    capabilities = capabilities
  })

  require('lspconfig')['yamlls'].setup({
    capabilities = capabilities
  })

  require('lint').linters_by_ft = {
    javascript = {'eslint_d'},
    typescript = {'eslint_d'},
    javascriptreact = {'eslint_d'},
    typescriptreact = {'eslint_d'},
  }

  require("conform").setup({
    formatters_by_ft = {
      -- Use a sub-list to run only the first available formatter
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      php = {},
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  })

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })

  require('nvim-treesitter.configs').setup({
    -- enable syntax highlighting
    highlight = {
      enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    autotag = {
      enable = true,
    },
    -- ensure these language parsers are installed
    ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "lua",
      "markdown",
      "markdown_inline",
      "graphql",
      "bash",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
    },
  })

  require'colorizer'.setup()

  require('neosolarized').setup({
    comment_italics = true,
    background_set = true,
  })

  local async = require "plenary.async"

  require('telescope').setup({})
  require('telescope').load_extension("fzf")

  -- set keymaps
  local keymap = vim.keymap -- for conciseness

  keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
  keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
  keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
  keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
EOF
