return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",  -- use the stable branch
    dependencies = {
      -- LSP Config
      "neovim/nvim-lspconfig",

      -- Autocompletion plugins
      "hrsh7th/nvim-cmp",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      "saadparwaiz1/cmp_luasnip",

      -- Snippet engine
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "neovim/nvim-lspconfig",

      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local lsp = require("lsp-zero").preset({

        name = "recommended",
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = true,
      })
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "rust_analyzer" }, -- add servers you want
        automatic_installation = true,
      })


      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)
    lsp.setup()
    end,
  }

