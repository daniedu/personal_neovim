return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then capabilities = cmp_nvim_lsp.default_capabilities() end

      vim.lsp.config.clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { ".clangd", ".git", "compile_commands.json" },
        capabilities = capabilities,
      }

      vim.lsp.config.tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js" },
        capabilities = capabilities,
      }

      vim.lsp.config.intelephense = {
        cmd = { "intelephense", "--stdio" },
        filetypes = { "php" },
        root_markers = { "composer.json", ".git" },
        capabilities = capabilities,
      }

      vim.lsp.config.nil_ls = {
        cmd = { "nil" },
        filetypes = { "nix" },
        root_markers = { ".git", "flake.nix" },
        capabilities = capabilities,
      }

      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        root_markers = { ".git", "tsconfig.json", "package.json" },
        capabilities = capabilities,
      }

      vim.lsp.config.ols = {
        cmd = { "ols" },
        filetypes = { "odin" },
        root_markers = { "ols.json", ".git" },
        capabilities = capabilities,
      }

      vim.lsp.enable("clangd")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("intelephense")
      vim.lsp.enable("nil_ls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("ols")

      rawset(vim.lsp.handlers, "textDocument/documentColor", nil)
      pcall(vim.lsp.document_color.enable)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = args.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = args.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    event = "VeryLazy",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      ast = { role_icons = {}, kind_icons = {} },
      memory_usage = { border = "rounded" },
      symbol_info = { border = "rounded" },
    },
  },
}
