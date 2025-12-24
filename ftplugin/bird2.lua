-- BIRD2 filetype plugin
-- This file runs when a bird2 file is opened

local bird2 = require("bird2")

-- Setup the plugin for this buffer
bird2.on_attach(0)

-- Define buffer-local commands
vim.api.nvim_buf_create_user_command(0, "Bird2", function(opts)
  local subcommand = opts.fargs[1]

  if subcommand == "version" then
    print("bird2.nvim 1.0.6")
  elseif subcommand == "check" then
    require("bird2.health").check()
  elseif subcommand == "disable" then
    vim.b.bird2_enabled = false
  elseif subcommand == "enable" then
    vim.b.bird2_enabled = true
  else
    print("Usage: Bird2 [version|check|enable|disable]")
  end
end, {
  nargs = "?",
  complete = function()
    return { "version", "check", "enable", "disable" }
  end,
  desc = "BIRD2 plugin commands",
})

-- Define buffer-local key mappings (user can override)
-- Comment/uncomment with <leader>c
if vim.fn.hasmapto("<Plug>Bird2Comment", "n") == 0 then
  vim.keymap.set("n", "<leader>c", "<Plug>Bird2Comment", {
    buffer = 0,
    desc = "Toggle comment",
  })
  vim.keymap.set("x", "<leader>c", "<Plug>Bird2Comment", {
    buffer = 0,
    desc = "Toggle comment (visual)",
  })
end

-- LSP configuration suggestions (for future use)
-- Uncomment if you have a BIRD2 LSP server
-- if vim.bo.filetype == "bird2" then
--   vim.lsp.start({
--     name = "bird2",
--     cmd = { "bird2-language-server" },
--     root_dir = vim.fs.root(0, { "bird.conf", "bird6.conf" }),
--   })
-- end
