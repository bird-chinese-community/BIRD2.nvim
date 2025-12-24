--- BIRD2 Neovim plugin
--- @class bird2.Config
--- @field enabled boolean Whether to enable the plugin
--- @field heuristic_detect boolean Enable heuristic detection for .conf files

local M = {}

--- Default configuration
--- @type bird2.Config
M.defaults = {
  enabled = true,
  heuristic_detect = true,
}

--- Module configuration
--- @type bird2.Config
M.config = M.defaults

--- Setup the plugin
--- @param opts? bird2.Config User configuration options
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.defaults, opts or {})

  if not M.config.enabled then
    return
  end

  -- Autocmd for BIRD2 files
  local augroup = vim.api.nvim_create_augroup("bird2", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "bird2",
    callback = function(args)
      M.on_attach(args.buf)
    end,
  })
end

--- Buffer-local setup when filetype is detected
--- @param bufnr number Buffer number
function M.on_attach(bufnr)
  bufnr = bufnr or 0

  -- Set comment format
  vim.bo[bufnr].commentstring = "# %s"
  vim.bo[bufnr].comments = ":#"

  -- Set format options
  vim.bo[bufnr].formatoptions = vim.bo[bufnr].formatoptions .. "croql"

  -- Set matchpairs
  vim.opt_local.matchpairs:append("(:)")
  vim.opt_local.matchpairs:append("{:}")
  vim.opt_local.matchpairs:append("[:]")

  -- Enable syntax sync
  vim.cmd("syntax sync fromstart")

  -- Create buffer-local key mappings
  M._create_mappings(bufnr)

  -- Run user autocommand
  vim.api.nvim_exec_autocmds("User", {
    pattern = "Bird2File",
    data = { buf = bufnr },
  })
end

--- Create buffer-local key mappings
--- @param bufnr number Buffer number
function M._create_mappings(bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- Comment/uncomment mappings
  if vim.fn.hasmapto("<Plug>Bird2Comment", "n") == 0 then
    vim.keymap.set("n", "<Plug>Bird2Comment", M._toggle_comment, opts)
    vim.keymap.set("x", "<Plug>Bird2Comment", M._toggle_comment_visual, opts)
  end
end

--- Toggle comment for current line
--- @param _ any Unused
function M._toggle_comment(_)
  local line = vim.api.nvim_get_current_line()
  local trimmed = line:match("^%s*(.*)")

  if trimmed:match("^#") then
    -- Uncomment
    local uncommented = line:gsub("^%s*#%s?", "", 1)
    vim.api.nvim_set_current_line(uncommented)
  else
    -- Comment
    local commented = line:gsub("^(%s*)", "%1# ", 1)
    vim.api.nvim_set_current_line(commented)
  end
end

--- Toggle comment for visual selection
function M._toggle_comment_visual()
  local start = vim.api.nvim_buf_get_mark(0, "<")
  local end_ = vim.api.nvim_buf_get_mark(0, ">")
  local start_row = start[1]
  local end_row = end_[1]

  for row = start_row, end_row do
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    local trimmed = line:match("^%s*(.*)")

    if trimmed:match("^#") then
      -- Uncomment
      local uncommented = line:gsub("^%s*#%s?", "", 1)
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { uncommented })
    else
      -- Comment
      local commented = line:gsub("^(%s*)", "%1# ", 1)
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { commented })
    end
  end
end

--- Check if a buffer looks like BIRD2 config
--- @param bufnr number Buffer number
--- @return boolean is_bird2
function M.looks_like_bird2(bufnr)
  bufnr = bufnr or 0
  local total = vim.api.nvim_buf_line_count(bufnr)
  local max = math.min(total, 200)

  -- Enhanced protocol list including newer BIRD protocols
  local protocols = {
    "bgp", "ospf", "rip", "device", "direct", "kernel", "pipe",
    "babel", "radv", "rpki", "bfd", "static", "l3vpn", "mrt", "perf"
  }

  for i = 0, max - 1 do
    local line = (vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1] or ""):lower()

    -- Skip empty lines and comments for better performance
    if line:match("^%s*$") or line:match("^%s*#") then
      goto continue
    end

    -- Core BIRD configuration patterns
    if line:match("^%s*router%s+id")
        or line:match("^%s*template%s+")
        or line:match("^%s*filter%s+")
        or line:match("^%s*function%s+")
        or line:match("^%s*table%s+")
        or line:match("^%s*define%s+")
        or line:match("%f[%w]flow[46]%f[^%w]")
        or line:match("%f[%w]roa[46]?%f[^%w]")
        or line:match("%f[%w]aspa%f[^%w]")
        or line:match("%f[%w]ipv[46]%s+table%f[^%w]")
    then
      return true
    end

    -- Protocol-specific detection
    for _, p in ipairs(protocols) do
      if line:match("^%s*protocol%s+" .. p .. "%f[^%w]") then
        return true
      end
    end

    ::continue::
  end

  return false
end

return M
