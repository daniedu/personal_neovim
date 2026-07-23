return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
            ["<C-k>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },

    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")

      local utils = require("telescope.previewers.utils")
      utils.ts_highlighter = function(bufnr, ft)
        if ft and ft ~= "" then
          local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
          if ok and lang then
            return pcall(vim.treesitter.start, bufnr, lang)
          end
        end
        return false
      end
    end,
  },
}
