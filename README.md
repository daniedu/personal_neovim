# personal_neovim

Standalone Neovim configuration ported from [personal_nvf](https://github.com/daniedu/personal_nvf).

## Quick install

```bash
# 1. Backup existing config & clone
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
git clone https://github.com/daniedu/personal_neovim ~/.config/nvim

# 2. Install system dependencies
sudo apt-get install ripgrep  # telescope live_grep

# 3. Install plugins & LSP servers
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonInstall clangd tailwindcss-language-server typescript-language-server intelephense blade-formatter prettierd eslint_d" +qa

# 4. Open and enjoy
nvim
```

> **Note:** `intelephense` requires a license. Skip it if you don't work with PHP.

## LSP servers (install via `:Mason`)

| Server | Filetypes | Mason command |
|---|---|---|
| clangd | c, cpp | `:MasonInstall clangd` |
| tailwindcss-language-server | css, html, js, ts, jsx, tsx | `:MasonInstall tailwindcss-language-server` |
| typescript-language-server | ts, js, tsx, jsx | `:MasonInstall typescript-language-server` |
| intelephense | php | `:MasonInstall intelephense` |
| nil | nix | `:MasonInstall nil` |
| ols | odin | `:MasonInstall ols` |
| blade-formatter | blade (Laravel) | `:MasonInstall blade-formatter` |
| eslint_d | js, ts, jsx, tsx | `:MasonInstall eslint_d` |

## Formatters (install via `:Mason`)

| Formatter | Filetypes | Mason command |
|---|---|---|
| prettierd | css, html, js, ts, json, yaml, md | `:MasonInstall prettierd` |
| stylua | lua | `:MasonInstall stylua` |
| gofumpt | go | `:MasonInstall gofumpt` |
| nixfmt | nix | `:MasonInstall nixfmt` |
| php-cs-fixer | php | `:MasonInstall php-cs-fixer` |
| shfmt | bash, sh | `:MasonInstall shfmt` |
| dart_format | dart | `:MasonInstall dart` |

## Key mappings

| Key | Action |
|---|---|
| `<Space>` | Leader |
| `<C-s>` | Format + save |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>e` | Toggle file tree |
| `<leader>xx` | Toggle diagnostics |
| `<leader>gg` | Toggle lazygit |
| `]d` / `[d` | Next / prev diagnostic |
| `<leader>wv` / `<leader>ws` | Vertical / horizontal split |
| `<leader>q` | Quit all |
| `<leader>h` | Clear search highlights |

## Theme

Gruvbox (soft contrast)

## Plugins

* alpha-nvim, indent-blankline, neo-tree, lualine, which-key
* nvim-cmp + luasnip + friendly-snippets
* nvim-treesitter + textobjects
* telescope + fzf-native
* conform.nvim (formatting)
* gitsigns, toggleterm + lazygit
* trouble, todo-comments, tiny-inline-diagnostic
* flash.nvim, vim-illuminate, vim-visual-multi
* autopairs, comment-nvim, surround
* clangd_extensions.nvim
