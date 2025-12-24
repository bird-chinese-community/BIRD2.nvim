# bird2.nvim

<div align="center">

**Neovim plugin for BIRD2 configuration files**

English | [简体中文](README.zh-CN.md)

[![License: MPL-2.0](https://img.shields.io/badge/License-MPL--2.0-blue.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)](https://neovim.io/)

</div>

## Overview

`bird2.nvim` provides Neovim support for [BIRD2](https://bird.network.cz/) configuration files, including syntax highlighting, filetype detection, and filetype plugin features.

This is the Neovim plugin component of the [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) project by the BIRD Chinese Community.

## Features

- Syntax highlighting for all BIRD2 configuration elements
- Automatic filetype detection for `.bird`, `.bird2`, `.bird3`, and `.conf` files
- Smart heuristic detection for generic `.conf` files using Lua patterns
- Filetype-specific settings (comments, format options, matchpairs)
- Built-in `:checkhealth` integration
- Modern Lua API for extensibility

## Installation

### Using lazy.nvim

```lua
{
  "bird-chinese-community/bird2.nvim",
  ft = "bird2",
  config = function()
    require("bird2").setup()
  end
}
```

### Using packer.nvim

```lua
use {
  "bird-chinese-community/bird2.nvim",
  config = function()
    require("bird2").setup()
  end
}
```

### Using vim-plug

```vim
Plug 'bird-chinese-community/bird2.nvim'
" Then in your Lua config:
lua require("bird2").setup()
```

### Manual Installation

```bash
git clone https://github.com/bird-chinese-community/bird2.nvim \
  ~/.local/share/nvim/site/pack/plugins/start/bird2.nvim
```

## Configuration

### Default Configuration

```lua
require("bird2").setup({
  enabled = true,
  heuristic_detect = true,
})
```

### Disable Heuristic Detection

```lua
require("bird2").setup({
  heuristic_detect = false,
})
```

### Custom Filetype Detection

```lua
vim.filetype.add({
  extension = {
    myext = "bird2",
  },
  pattern = {
    [".*%.myconf"] = "bird2",
  },
})
```

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `:Bird2 version` | Show plugin version |
| `:Bird2 check` | Run health checks |
| `:Bird2 enable` | Enable plugin for current buffer |
| `:Bird2 disable` | Disable plugin for current buffer |

### Health Check

```vim
:checkhealth bird2
```

Or use the custom command:

```vim
:Bird2 check
```

### User Autocommand

Listen to the `Bird2File` event:

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "Bird2File",
  callback = function(args)
    local bufnr = args.data.buf
    -- Your custom setup for bird2 files
  end,
})
```

## API

### `setup(opts)`

Initialize the plugin with options.

```lua
---@class bird2.Config
---@field enabled boolean Whether to enable the plugin
---@field heuristic_detect boolean Enable heuristic detection for .conf files
require("bird2").setup({
  enabled = true,
  heuristic_detect = true,
})
```

### `on_attach(bufnr)`

Manually trigger buffer setup.

```lua
require("bird2").on_attach(0)
```

### `looks_like_bird2(bufnr)`

Check if a buffer looks like BIRD2 configuration.

```lua
local is_bird2 = require("bird2").looks_like_bird2(0)
```

## Documentation

After installation, view the help documentation:

```vim
:help bird2
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Running Tests

```bash
luarocks install --only-deps
luarocks test
```

## License

- Plugin files: [Mozilla Public License 2.0](LICENSE)
- Copyright (c) BIRD Chinese Community

## Related Projects

- [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) - TextMate grammar for BIRD2
- [bird2.vim](https://github.com/bird-chinese-community/bird2.vim) - Vim plugin
- [vscode-bird2](https://github.com/bird-chinese-community/vscode-bird2-conf) - VS Code extension

## Acknowledgments

This plugin is maintained by the [BIRD Chinese Community](https://github.com/bird-chinese-community).
