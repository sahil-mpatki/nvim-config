return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- For LSP completion capabilities
      "williamboman/mason.nvim", -- Optional: for managing LSP servers
      "williamboman/mason-lspconfig.nvim", -- Bridges mason and lspconfig
    },
    config = function()
      -- Add cmp_nvim_lsp capabilities to LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Optional: Set up mason-lspconfig to auto-install LSP servers
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" }, -- Example servers
      })

      -- Configure LSP servers
      local lspconfig = require("lspconfig")

      -- clangd language server 
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

    end,
  },
}
