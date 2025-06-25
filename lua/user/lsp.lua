-- === LSP Setup ===
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Optional: common `on_attach` and `capabilities` helpers for all LSPs
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(_, bufnr)
  -- You can define keymaps for LSP features here

  local opts = { buffer = bufnr }

-- go to def
vim.keymap.set('n','gd', vim.lsp.buf.definition, opts)
end

-- C/C++
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- templ?
lspconfig.templ.setup{}

-- js
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = require('lspconfig.util').root_pattern("package.json", "tsconfig.json", ".git")
})


-- Python (Pyright)
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
	  python = {
		  analysis = {
			  typeCheckingMode = "off", 
		  }
	  }
  }
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    }
  }
})

-- Protobuf support via `bufls` (optional)
-- Install via: `go install github.com/bufbuild/buf-language-server/cmd/bufls@latest`
lspconfig.buf_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "bufls", "serve" },
  filetypes = { "proto" },
})

-- === CMP (Autocomplete) ===
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- === Treesitter ===
require("nvim-treesitter.configs").setup {
  ensure_installed = { "cpp", "c", "python", "proto", "vimdoc", "templ", "go" },
  highlight = { enable = true },
}


-- === UI Plugins ===
require("lualine").setup()
require("nvim-tree").setup()

