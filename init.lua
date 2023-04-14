local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('morhetz/gruvbox')
Plug('ryanoasis/vim-devicons')
Plug('preservim/nerdtree')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-telescope/telescope.nvim')
Plug('tpope/vim-endwise')
Plug('Yggdroot/indentLine')
Plug('vim-ruby/vim-ruby')
Plug('mlochbaum/BQN', { rtp = 'editors/vim' })
Plug('calebowens/nvim-bqn')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/nvim-cmp')
Plug('sheerun/vim-polyglot')
Plug('jaredgorski/fogbell.vim')
Plug('github/copilot.vim')

vim.call('plug#end')
 
_G.caleb = {}

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.bqn" }, command = "setlocal spell" }
)

 -- Nerd tree
vim.g.NERDTreeChDirMode = 2 -- Change cwd to parent node

vim.g.NERDTreeMinimalUI = 1 -- Hide help text
vim.g.NERDTreeAutoDeleteBuffer = 1

vim.g.NERDTreeWinSize = 25

vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeDirArrowExpandable = ''
vim.g.NERDTreeDirArrowCollapsible = ''


 -- Fix issue with nerd tree menu
vim.g.NERDTreeMinimalMenu = 1

vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', 'FF', '', {
    noremap = true,
    callback = function()
        require('telescope.builtin').find_files()
    end
})

vim.api.nvim_set_keymap('n', 'FG', '', {
    noremap = true,
    callback = function()
        require('telescope.builtin').live_grep()
    end
})

vim.api.nvim_set_keymap('n', 'FB', '', {
    noremap = true,
    callback = function()
        require('telescope.builtin').buffers()
    end
})

vim.api.nvim_set_keymap('n', 'FH', '', {
    noremap = true,
    callback = function()
        require('telescope.builtin').help_tags()
    end
})

vim.cmd('set background=dark')
vim.cmd('colorscheme fogbell_light')

vim.opt.expandtab = nil
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = nil

vim.g.indentLine_char = '▏'
vim.g.vim_json_conceal=0
vim.g.markdown_syntax_conceal=0


vim.g.rubycomplete_buffer_loading = 1
vim.g.rubycomplete_classes_in_global = 1
vim.g.rubycomplete_rails = 1
vim.g.rubycomplete_load_gemfile = 1

vim.g.ruby_indent_access_modifier_style = 'normal'
vim.g.ruby_indent_block_style = 'do'
vim.g.ruby_indent_assignment_style = 'hanging'
vim.g.ruby_indent_hanging_elements = 1

vim.opt.mouse = nil


vim.opt.listchars:append('trail:!')
vim.opt.list = nil

vim.g.loaded_perl_provider = 0


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

end

-- TTS

local tts = {}

local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
 else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

local mappings = {
  ['('] = ' open bracket ',
  [')'] = ' close bracket ',
  ['['] = ' open square bracket ',
  [']'] = ' close square bracket ',
  ['{'] = ' open curly bracket ',
  ['}'] = ' close curly bracket ',
  ['\''] =' single quote ',
  ['"'] = ' doubble qoute ',
  ['!'] = ' exclamation ',
  ['@'] = ' at ',
  ['£'] = ' pound ',
  ['$'] = ' dollar ',
  ['%'] = ' percent ',
  ['^'] = ' hat ',
  ['&'] = ' ampersand ',
  ['*'] = ' asterisk ',
  ['.'] = ' period ',
  [','] = ' comma ',
  ['`'] = ' back tick ',
  ['#'] = ' octothorpe ',
  ['\\'] = ' back slash ',
  ['/'] = ' forward slash ',
  ['|'] = ' pipe ',
  ['~'] = ' tilde ',
  [':'] = ' colon ',
  [';'] = ' semi colon ',
  ['?'] = ' question mark '
}

local function substitute_symbols(str)
  return string.gsub(str, mappings)
end

function tts.read_selection()
  os.execute('say ' .. vim.fn.shellescape(substitute_symbols(get_visual_selection())))
end

vim.keymap.set('v', '<leader>f', ':<C-u>call v:lua.caleb.tts.read_selection()<CR>', { silent=true })

_G.caleb.tts = tts

--[[
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

local cmp = require'cmp'

cmp.setup({
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
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

require('lspconfig')['tsserver'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
}

require('lspconfig')['solargraph'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}

require('lspconfig')['rust_analyzer'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
--]]
