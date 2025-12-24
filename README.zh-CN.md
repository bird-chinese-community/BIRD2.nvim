# bird2.nvim

<div align="center">

**BIRD2 配置文件的 Neovim 插件**

[English](README.md) | 简体中文

[![License: MPL-2.0](https://img.shields.io/badge/License-MPL--2.0-blue.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)](https://neovim.io/)

</div>

## 概述

`bird2.nvim` 为 [BIRD2](https://bird.network.cz/) 配置文件提供 Neovim 支持，包括语法高亮、文件类型检测和文件类型插件功能。

这是 [BIRD 中文社区](https://github.com/bird-chinese-community) 的 [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) 项目的 Neovim 插件组件。

## 功能特性

- 完整的 BIRD2 配置语法高亮
- 自动文件类型检测（`.bird`, `.bird2`, `.bird3`, `.conf` 等扩展名）
- 对通用 `.conf` 文件的智能启发式检测（使用 Lua 模式匹配）
- 文件类型特定设置（注释、格式选项、匹配对等）
- 内置 `:checkhealth` 集成
- 现代 Lua API 支持扩展

## 安装

### 使用 lazy.nvim

```lua
{
  "bird-chinese-community/bird2.nvim",
  ft = "bird2",
  config = function()
    require("bird2").setup()
  end
}
```

### 使用 packer.nvim

```lua
use {
  "bird-chinese-community/bird2.nvim",
  config = function()
    require("bird2").setup()
  end
}
```

### 使用 vim-plug

```vim
Plug 'bird-chinese-community/bird2.nvim'
" 然后在 Lua 配置中：
lua require("bird2").setup()
```

### 手动安装

```bash
git clone https://github.com/bird-chinese-community/bird2.nvim \
  ~/.local/share/nvim/site/pack/plugins/start/bird2.nvim
```

## 配置

### 默认配置

```lua
require("bird2").setup({
  enabled = true,
  heuristic_detect = true,
})
```

### 禁用启发式检测

```lua
require("bird2").setup({
  heuristic_detect = false,
})
```

### 自定义文件类型检测

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

## 使用

### 命令

| 命令 | 描述 |
|------|------|
| `:Bird2 version` | 显示插件版本 |
| `:Bird2 check` | 运行健康检查 |
| `:Bird2 enable` | 为当前缓冲区启用插件 |
| `:Bird2 disable` | 为当前缓冲区禁用插件 |

### 健康检查

```vim
:checkhealth bird2
```

或使用自定义命令：

```vim
:Bird2 check
```

### 用户自动命令

监听 `Bird2File` 事件：

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "Bird2File",
  callback = function(args)
    local bufnr = args.data.buf
    -- 为 bird2 文件添加自定义设置
  end,
})
```

## API

### `setup(opts)`

使用选项初始化插件。

```lua
---@class bird2.Config
---@field enabled boolean 是否启用插件
---@field heuristic_detect boolean 为 .conf 文件启用启发式检测
require("bird2").setup({
  enabled = true,
  heuristic_detect = true,
})
```

### `on_attach(bufnr)`

手动触发缓冲区设置。

```lua
require("bird2").on_attach(0)
```

### `looks_like_bird2(bufnr)`

检查缓冲区是否看起来像 BIRD2 配置。

```lua
local is_bird2 = require("bird2").looks_like_bird2(0)
```

## 文档

安装后，可查看帮助文档：

```vim
:help bird2
```

## 贡献

欢迎贡献！请随时提交 Pull Request。

### 运行测试

```bash
luarocks install --only-deps
luarocks test
```

## 许可证

- 插件文件：[Mozilla Public License 2.0](LICENSE)
- 版权所有 (c) BIRD 中文社区

## 相关项目

- [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) - BIRD2 的 TextMate 语法
- [bird2.vim](https://github.com/bird-chinese-community/bird2.vim) - Vim 插件
- [vscode-bird2](https://github.com/bird-chinese-community/vscode-bird2-conf) - VS Code 扩展

## 鸣谢

此插件由 [BIRD 中文社区](https://github.com/bird-chinese-community) 维护。
