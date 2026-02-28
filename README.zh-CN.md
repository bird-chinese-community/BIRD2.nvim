# BIRD2.vim

<div align="center">

**BIRD2 配置文件的 Vim 插件**

Version: [English](README.md) | 简体中文

<!-- Badge -->

[![MPL-2.0 许可证](https://img.shields.io/badge/License-MPL--2.0-blue?style=flat-square)](LICENSE)
[![Vim 8.0+](https://img.shields.io/badge/Vim-8.0+-green?style=flat-square&logo=vim)](https://www.vim.org/)
[![GitHub Stars](https://img.shields.io/github/stars/bird-chinese-community/BIRD2.vim?style=flat-square&logo=github)](https://github.com/bird-chinese-community/BIRD2.vim)
[![GitHub Issues](https://img.shields.io/github/issues/bird-chinese-community/BIRD2.vim?style=flat-square&logo=github)](https://github.com/bird-chinese-community/BIRD2.vim/issues)
[![维护状态](https://img.shields.io/badge/维护中-是-success?style=flat-square)](https://github.com/bird-chinese-community/BIRD2.vim/graphs/commit-activity)

<!-- 预览图片 -->

![BIRD2.vim 预览](https://raw.githubusercontent.com/bird-chinese-community/BIRD-tm-language-grammar/main/.github/assets/bird2-grammar-vim-preview.jpg)

</div>

---

## 目录

- [BIRD2.vim](#bird2vim)
  - [目录](#目录)
  - [概述](#概述)
  - [功能特性](#功能特性)
  - [安装](#安装)
    - [使用 vim-plug](#使用-vim-plug)
    - [使用 Vundle](#使用-vundle)
    - [使用 pack.nvim (Neovim/Vim 8+)](#使用-packnvim-neovimvim-8)
  - [文件类型检测](#文件类型检测)
  - [文档](#文档)
  - [配置](#配置)
    - [禁用启发式检测](#禁用启发式检测)
    - [自定义文件扩展名](#自定义文件扩展名)
  - [贡献](#贡献)
  - [许可证](#许可证)
  - [相关项目](#相关项目)

---

## 概述

`BIRD2.vim` 为 [BIRD2](https://bird.network.cz/) 配置文件提供 Vim 语法高亮、文件类型检测和文件类型插件支持。

这是 [BIRD 中文社区](https://github.com/bird-chinese-community) 的 [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) 项目的 Vim 插件组件。

---

## 功能特性

- :rainbow: **语法高亮** - 完整的 BIRD2 配置语法高亮
- :mag: **自动文件类型检测** - 支持 `.bird`, `.bird2`, `.bird3`, `.conf` 等扩展名
- :brain: **智能启发式检测** - 对通用 `.conf` 文件的内容检测
- :wrench: **文件类型特定设置** - 注释、格式选项等
- :book: **内置帮助文档** - 通过 `:help bird2` 访问

---

## 安装

<details>
<summary><b>:package: 快速安装</b></summary>

选择你喜欢的插件管理器：

### 使用 vim-plug

```vim
Plug 'bird-chinese-community/BIRD2.vim'
```

```vim
Plugin 'bird-chinese-community/BIRD2.vim'
```

### 使用 pack.nvim (Neovim/Vim 8+)

```vim
packadd! BIRD2.vim
```

或手动克隆到 pack 目录：

```bash
git clone https://github.com/bird-chinese-community/BIRD2.vim \
  ~/.vim/pack/plugins/start/BIRD2.vim
```

</details>

<details>
<summary><b>:wrench: 手动安装</b></summary>

```bash
# 克隆仓库
git clone https://github.com/bird-chinese-community/BIRD2.vim.git
cd BIRD2.vim

# 运行安装脚本
bash scripts/install.sh
```

这会将语法文件安装到你的 `~/.vim` 目录。

</details>

---

## 文件类型检测

- **:page_facing_up: 扩展名**：`.bird`, `.bird2`, `.bird3`, `.bird*.conf`
- **:file_folder: 文件名**：`bird.conf`, `bird6.conf`
- **:mag: 内容检测**：扫描 `.conf` 文件的前 200 行，查找 BIRD2 特定模式：
  - 协议定义（`protocol bgp`, `protocol ospf` 等）
  - 关键字如 `router id`, `template`, `filter`, `function`
  - Flow/ROA 表定义

---

## 文档

安装后，可查看帮助文档：

```vim
:help bird2
```

重新生成帮助标签：

```vim
:helptags ~/.vim/doc
```

---

## 配置

无需配置即可使用。

<details>
<summary><b>:gear: 高级选项</b></summary>

### 禁用启发式检测

如需禁用 `.conf` 文件的内容检测：

```vim
let g:bird2_heuristic_detect = 0
```

### 自定义文件扩展名

添加自定义文件扩展名：

```vim
autocmd BufRead,BufNewFile *.myext setfiletype bird2
```

</details>

---

## 贡献

### 同步语法源

`syntax/bird2.vim` 保持为普通文件，确保本仓库单独安装时也可正常工作。

从 `bird2.vim` 同步语法更新：

```bash
bash scripts/sync-syntax.sh
```

也可指定显式源路径：

```bash
bash scripts/sync-syntax.sh /path/to/bird2.vim/syntax/bird2.vim
```

欢迎贡献！请随时提交 Pull Request。

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 打开 Pull Request

---

## 许可证

- 插件文件：[Mozilla Public License 2.0](LICENSE)
- 版权所有 (c) BIRD 中文社区

---

## 相关项目

- :bookmark: [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) - BIRD2 的 TextMate 语法
- :star: [bird2.nvim](https://github.com/bird-chinese-community/bird2.nvim) - Neovim 插件
- :electric_plug: [vscode-bird2](https://github.com/bird-chinese-community/vscode-bird2-conf) - VS Code 扩展

---

<div align="center">

用 :heart: 维护，由 [BIRD 中文社区](https://github.com/bird-chinese-community) 呈现

</div>
