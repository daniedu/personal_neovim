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
    init = function()
      local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
      if parsers_ok then
        if not parsers.ft_to_lang then
          parsers.ft_to_lang = function(ft)
            local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
            return ok and lang or ft
          end
        end
        if not parsers.get_parser then
          parsers.get_parser = function(bufnr, lang)
            return vim.treesitter.get_parser(bufnr, lang)
          end
        end
      else
        package.loaded["nvim-treesitter.parsers"] = {
          ft_to_lang = function(ft)
            local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
            return ok and lang or ft
          end,
          get_parser = function(bufnr, lang)
            return vim.treesitter.get_parser(bufnr, lang)
          end,
        }
      end

      local configs_ok, _ = pcall(require, "nvim-treesitter.configs")
      if not configs_ok then
        package.loaded["nvim-treesitter.configs"] = {
          is_enabled = function() return true end,
          get_module = function() return {} end,
        }
      end
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
