-- Tests for bird2.nvim
describe("bird2.nvim", function()
  local bird2 = require("bird2")

  it("can be required", function()
    assert.is_not_nil(bird2)
  end)

  it("has default configuration", function()
    assert.is_not_nil(bird2.defaults)
    assert.is_true(bird2.defaults.enabled)
    assert.is_true(bird2.defaults.heuristic_detect)
  end)

  it("setup merges user config", function()
    local test_config = { enabled = false, heuristic_detect = false }
    bird2.setup(test_config)
    assert.is_false(bird2.config.enabled)
    assert.is_false(bird2.config.heuristic_detect)
    -- Reset to defaults
    bird2.setup(bird2.defaults)
  end)

  describe("looks_like_bird2", function()
    before_each(function()
      -- Create a test buffer
      vim.cmd("enew")
    end)

    after_each(function()
      -- Clean up
      vim.cmd("bdelete!")
    end)

    it("detects protocol bgp", function()
      local lines = { "protocol bgp {" }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      assert.is_true(bird2.looks_like_bird2(0))
    end)

    it("detects router id", function()
      local lines = { "router id 1.2.3.4;" }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      assert.is_true(bird2.looks_like_bird2(0))
    end)

    it("detects filter definition", function()
      local lines = { "filter import_network {" }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      assert.is_true(bird2.looks_like_bird2(0))
    end)

    it("returns false for non-BIRD content", function()
      local lines = {
        "# This is not BIRD config",
        "some random text",
        "more random stuff",
      }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      assert.is_false(bird2.looks_like_bird2(0))
    end)

    it("skips comments", function()
      local lines = {
        "# Comment line",
        "# Another comment",
        "protocol bgp {",
      }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      assert.is_true(bird2.looks_like_bird2(0))
    end)
  end)

  describe("on_attach", function()
    before_each(function()
      vim.cmd("enew")
      vim.bo.filetype = "bird2"
    end)

    after_each(function()
      vim.cmd("bdelete!")
    end)

    it("sets buffer options", function()
      bird2.on_attach(0)
      assert.equals("# %s", vim.bo.commentstring)
      assert.equals(":#", vim.bo.comments)
    end)

    it("creates <Plug> mappings", function()
      bird2.on_attach(0)
      -- Check if <Plug> mapping exists
      local result = vim.fn.maparg("<Plug>Bird2Comment", "n", false, true)
      assert.is_not_nil(result)
      assert.is_not_nil(result.callback)
    end)
  end)

  describe("health", function()
    it("can run health check", function()
      local health = require("bird2.health")
      assert.is_not_nil(health)
      assert.is_function(health.check)
    end)
  end)
end)
