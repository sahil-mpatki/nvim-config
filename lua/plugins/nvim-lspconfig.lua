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
        ensure_installed = { "lua_ls", "pyright", "tsserver" }, -- Example servers
      })

      -- Configure LSP servers
      local lspconfig = require("lspconfig")

      -- Lua language server (lua_ls)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } }, -- Recognize vim globals
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      -- clangd language server 
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- Keymaps for LSP functionality
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        end,
      })

      -- Optional: Customize diagnostics display
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
      })
    end,
  },
}
