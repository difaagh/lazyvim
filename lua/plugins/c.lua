vim.filetype.add({
  extension = { ["x"] = "objc" },
})
local home = os.getenv("HOME")
local cache_dir = home .. "/.cache/ccls"
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ccls = {
        mason = false,
        cmd = { "ccls", '--init={"cache": {"directory": "' .. cache_dir .. '"}}' },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "x" },
        root_dir = require("lspconfig.util").root_pattern("compile_commands.json"),
      },
    },
  },
}
