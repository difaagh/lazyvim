local ruby_version = vim.fn.system("ruby -v"):match("(%d+%.%d+%.%d+)")
local ruby_minimal_version = "3.0.0"
local solargraph = {}
local rubocop = {}

-- only override necessary settings
if ruby_version then
  -- use solargraph and rubocop system
  if ruby_version <= ruby_minimal_version then
    solargraph = {
      mason = false,
      formatting = false,
    }
    -- old ruby version typically doesn't support higher rubocop version for example
    -- ruby version 2.6.10 use rubocop 1.15.0 version. this version is not support --lsp or --server argument
    -- use rubocop cmd without the argument
    rubocop = {
      mason = false,
      cmd = { "rubocop" },
    }
    -- solargraph and rubocop use mason installation
  else
    solargraph = {
      mason = true,
      formatting = false,
    }
    rubocop = {
      mason = true,
    }
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = rubocop,
        solargraph = solargraph,
      },
    },
  },

  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
  },
}
