return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
      })
    end,
  },
  {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  config = function()
    require("go").setup()

    -- Setup manual gopls with nvim-lspconfig
    require('lspconfig').gopls.setup{
      cmd = { "/root/go/bin/gopls" }, -- Adjust this path if needed
      on_attach = function(client, bufnr)
        -- Additional configuration if needed
      end,
    }

    -- Run gofmt + goimport on save
    local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
      end,
      group = format_sync_grp,
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  keys = {
    { "<leader>gaj", "<cmd>GoAddTag<cr>", desc = "Add json tags" },
    { "<leader>gam", "<cmd>GoAddTag mapstructure<cr>", desc = "Add mapstructure tags" },
    { "<leader>gae", "<cmd>GoAddTag env<cr>", desc = "Add env tags" },
    { "<leader>gay", "<cmd>GoAddTag yaml<cr>", desc = "Add YAML tags" },
    { "<leader>gim", "<cmd>GoImplements<cr>", desc = "Find implementions of this method" },
   },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          mason = false,  -- disable auto download gopls in mason
        }
      },
    },
  },
}
