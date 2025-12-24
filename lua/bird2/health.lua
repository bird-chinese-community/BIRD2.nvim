--- Health check module for bird2.nvim
local M = {}

--- Run health checks
function M.check()
  vim.health.start("bird2.nvim")

  -- Check if plugin is loaded
  local bird2 = package.loaded["bird2"]
  if bird2 then
    vim.health.ok("Plugin loaded")
  else
    vim.health.warn("Plugin not loaded yet")
  end

  -- Check syntax file
  local syntax_path = debug.getinfo(1).source:match("@?(.*/)") .. "../syntax/bird2.vim"
  syntax_path = vim.fn.fnamemodify(syntax_path, ":p")

  if vim.fn.filereadable(syntax_path) == 1 then
    vim.health.ok("Syntax file found: " .. syntax_path)
  else
    vim.health.error("Syntax file not found: " .. syntax_path)
  end

  -- Check Lua version
  local lua_version = _VERSION
  if lua_version then
    vim.health.info("Lua version: " .. lua_version)
  end

  -- Check Neovim version
  local nvim_version = vim.version()
  local version_str = string.format("v%d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch)
  if nvim_version.major >= 0 and nvim_version.minor >= 9 then
    vim.health.ok("Neovim version: " .. version_str)
  else
    vim.health.warn("Neovim 0.9.0+ recommended (current: " .. version_str .. ")")
  end

  -- Check for filetypes
  local ft_detect = vim.fn.glob(vim.fn.stdpath("config") .. "/plugin/*bird*.lua", true, true)
  if #ft_detect > 0 then
    vim.health.ok("Filetype detection installed")
  else
    vim.health.warn("Filetype detection may not be installed")
  end

  vim.health.info("For help, see: https://github.com/bird-chinese-community/bird2.nvim")
end

return M
