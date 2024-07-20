local ruby_version = vim.fn.system("ruby -v"):match("(%d+%.%d+%.%d+)")
local ruby_minimal_version = "3.0.0"
local rubocop = {}

-- only override necessary settings
if ruby_version then
  -- custom rubocop lsp setting
  if ruby_version < ruby_minimal_version then
    -- old ruby version typically doesn't support higher rubocop version
    -- for example ruby version 2.6.10 use rubocop 1.15.0 version. this version is not support --lsp or --server argument
    -- use rubocop cmd without the argument
    rubocop = {
      mason = false,
      cmd = { "rubocop" },
    }
  else
    -- use default cmd provided by nvim-lspconfig
    rubocop = {
      mason = false,
    }
  end
end

return {
  -- ruby syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },
  -- slim template syntax highlighting
  {
    "slim-template/vim-slim",
  },

  -- ruby language server protocol
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = rubocop,
        solargraph = {
          mason = false,
          formatting = false,
        },
        sorbet = {
          -- use sorbet local package
          -- TODO: check wether need to use global or local package
          cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--typed=true" },
          mason = false,
          root_dir = function(in_current_path)
            return require("lspconfig.util").root_pattern("Gemfile")(in_current_path)
          end,
        },
      },
    },
  },

  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
  },
}
