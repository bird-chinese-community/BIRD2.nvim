-- BIRD2 filetype registration (Neovim Lua)
-- This file registers the filetype and provides content-based detection

local api = vim.api
local bird2 = require("bird2")

-- Register filetype detection using modern Neovim API
if vim.filetype and vim.filetype.add then
  vim.filetype.add({
    extension = {
      bird = "bird2",
      bird2 = "bird2",
      bird3 = "bird2",
    },
    filename = {
      ["bird.conf"] = "bird2",
      ["bird6.conf"] = "bird2",
    },
    pattern = {
      -- Pattern matching for BIRD config files
      [".*/bird.*%.conf$"] = "bird2",
      [".*%.bird.*%.conf$"] = "bird2",
      -- Generic .conf files require content inspection
      [".*%.conf$"] = function(path, bufnr)
        if require("bird2.config").heuristic_enabled() and bird2.looks_like_bird2(bufnr) then
          return "bird2"
        end
      end,
    },
  })
end

-- Fallback mechanism: handle cases where filetype is initially set to 'conf'
-- but should be 'bird2' based on content
api.nvim_create_autocmd({ "BufRead", "BufNewFile", "FileType" }, {
  pattern = "*.conf",
  callback = function(args)
    local bufnr = args.buf
    local current_ft = vim.bo[bufnr].filetype

    -- Skip if already correctly detected as bird2
    if current_ft == "bird2" then
      return
    end

    -- Only override if filetype is empty or 'conf'
    if current_ft ~= "" and current_ft ~= "conf" then
      return
    end

    -- Apply heuristic detection
    if require("bird2.config").heuristic_enabled() and bird2.looks_like_bird2(bufnr) then
      vim.bo[bufnr].filetype = "bird2"
    end
  end,
  desc = "BIRD2: Set filetype for .conf files based on content",
})

-- Register health check
vim.api.nvim_create_user_command("Bird2Health", function()
  require("bird2.health").check()
end, { desc = "Check bird2.nvim health" })
