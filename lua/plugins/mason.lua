return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      providers = {
        "mason.providers.client",
        "mason.providers.registry-api", -- This is 
      },
      log_level = vim.log.levels.DEBUG
    })
  end
}
