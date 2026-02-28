# BIRD2.vim

<div align="center">

**Vim syntax highlighting for BIRD2 configuration files**

Version: English | [简体中文](README.zh-CN.md)

<!-- Badge -->

[![MPL-2.0 License](https://img.shields.io/badge/License-MPL--2.0-blue?style=flat-square)](LICENSE)
[![Vim 8.0+](https://img.shields.io/badge/Vim-8.0+-green?style=flat-square&logo=vim)](https://www.vim.org/)
[![GitHub Stars](https://img.shields.io/github/stars/bird-chinese-community/BIRD2.vim?style=flat-square&logo=github)](https://github.com/bird-chinese-community/BIRD2.vim)
[![GitHub Issues](https://img.shields.io/github/issues/bird-chinese-community/BIRD2.vim?style=flat-square&logo=github)](https://github.com/bird-chinese-community/BIRD2.vim/issues)
[![Maintenance](https://img.shields.io/badge/Maintained-Yes-success?style=flat-square)](https://github.com/bird-chinese-community/BIRD2.vim/graphs/commit-activity)

<!-- Preview Image -->

![BIRD2.vim Preview](https://raw.githubusercontent.com/bird-chinese-community/BIRD-tm-language-grammar/main/.github/assets/bird2-grammar-vim-preview.jpg)

</div>

---

## Table of Contents

- [BIRD2.vim](#bird2vim)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Features](#features)
  - [Installation](#installation)
    - [Using vim-plug](#using-vim-plug)
    - [Using Vundle](#using-vundle)
    - [Using pack.nvim (Neovim/Vim 8+)](#using-packnvim-neovimvim-8)
  - [Filetype Detection](#filetype-detection)
  - [Documentation](#documentation)
  - [Configuration](#configuration)
    - [Disable heuristic detection](#disable-heuristic-detection)
    - [Custom file extensions](#custom-file-extensions)
  - [Contributing](#contributing)
  - [License](#license)
  - [Related Projects](#related-projects)

---

## Overview

`BIRD2.vim` provides Vim syntax highlighting, filetype detection, and filetype plugin support for [BIRD2](https://bird.network.cz/) configuration files.

This is the Vim plugin component of the [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) project by the **BIRD Chinese Community**.

---

## Features

- :rainbow: **Syntax highlighting** for all BIRD2 configuration elements
- :mag: **Automatic filetype detection** for `.bird`, `.bird2`, `.bird3`, and `.conf` files
- :brain: **Smart heuristic detection** for generic `.conf` files
- :wrench: **Filetype-specific settings** (comments, format options, etc.)
- :book: **Built-in help documentation** accessible via `:help bird2`

---

## Installation

<details>
<summary><b>:package: Quick Installation</b></summary>

Choose your preferred plugin manager:

### Using vim-plug

```vim
Plug 'bird-chinese-community/BIRD2.vim'
```

```vim
Plugin 'bird-chinese-community/BIRD2.vim'
```

### Using pack.nvim (Neovim/Vim 8+)

```vim
packadd! BIRD2.vim
```

Or manually clone to your pack directory:

```bash
git clone https://github.com/bird-chinese-community/BIRD2.vim \
  ~/.vim/pack/plugins/start/BIRD2.vim
```

</details>

<details>
<summary><b>:wrench: Manual Installation</b></summary>

```bash
# Clone the repository
git clone https://github.com/bird-chinese-community/BIRD2.vim.git
cd BIRD2.vim

# Run the installation script
bash scripts/install.sh
```

This will install the syntax files to your `~/.vim` directory.

</details>

---

## Filetype Detection

- **:page_facing_up: Extension**: `.bird`, `.bird2`, `.bird3`, `.bird*.conf`
- **:file_folder: Filename**: `bird.conf`, `bird6.conf`
- **:mag: Content**: Scans first 200 lines of `.conf` files for BIRD2-specific patterns:
  - Protocol definitions (`protocol bgp`, `protocol ospf`, etc.)
  - Keywords like `router id`, `template`, `filter`, `function`
  - Flow/ROA table definitions

---

## Documentation

After installation, view the help documentation:

```vim
:help bird2
```

To regenerate help tags:

```vim
:helptags ~/.vim/doc
```

---

## Configuration

No configuration is required. The plugin works out of the box.

<details>
<summary><b>:gear: Advanced Options</b></summary>

### Disable heuristic detection

If you want to disable content-based detection for `.conf` files:

```vim
let g:bird2_heuristic_detect = 0
```

### Custom file extensions

To add custom file extensions:

```vim
autocmd BufRead,BufNewFile *.myext setfiletype BIRD2
```

</details>

---

## Contributing

### Sync Syntax Source

`syntax/bird2.vim` is stored as a regular file so this repository works when installed standalone.

To sync syntax updates from `bird2.vim`:

```bash
bash scripts/sync-syntax.sh
```

Or use an explicit source path:

```bash
bash scripts/sync-syntax.sh /path/to/bird2.vim/syntax/bird2.vim
```

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

- Plugin files: [Mozilla Public License 2.0](LICENSE)
- Copyright (c) BIRD Chinese Community (BIRDCC)

---

## Related Projects

- :bookmark: [BIRD-tm-language-grammar](https://github.com/bird-chinese-community/bird-tm-language-grammar) - TextMate grammar for BIRD2
- :star: [bird2.nvim](https://github.com/bird-chinese-community/bird2.nvim) - Neovim plugin
- :electric_plug: [vscode-bird2](https://github.com/bird-chinese-community/vscode-bird2-conf) - VS Code extension

---

<div align="center">

Maintained with :heart: by the [BIRD Chinese Community](https://github.com/bird-chinese-community)

</div>
