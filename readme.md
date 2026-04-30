# nvim-local

个人 Neovim 配置，主要面向 **Go 开发** + 通用文本编辑。

- 插件管理：[lazy.nvim](https://github.com/folke/lazy.nvim)（`lazy-lock.json` 锁定版本，新机器一致性好）
- LSP：使用 Neovim 0.11+ 内置 `vim.lsp.config` API（不依赖 nvim-lspconfig）
- 主题：Catppuccin
- 字体：JetBrainsMono Nerd Font
- Leader 键：`,`（逗号）

---

## Quick Start

### 1. 前置条件

- macOS（脚本暂只支持 macOS；Linux 需自行调整）
- 已安装 [Homebrew](https://brew.sh)
- 已经把仓库 clone 到 `~/.config/nvim`：

```bash
git clone git@github.com:007Caption/nvim-local.git ~/.config/nvim
```

### 2. 一键安装

```bash
cd ~/.config/nvim && ./install.sh
```

脚本会自动：

1. 检查 / 安装 Neovim（要求 ≥ 0.11）
2. 安装运行时依赖：`git` `ripgrep` `fd` `go` `node`
3. 安装 JetBrainsMono Nerd Font
4. 跑 `:Lazy! sync` 按 `lazy-lock.json` 拉取所有插件
5. 跑 `:MasonInstall gopls` 安装 Go LSP

### 3. 终端字体

把终端字体设置成 **JetBrainsMono Nerd Font**（iTerm2 / Ghostty / WezTerm 等都在偏好设置里），否则文件树和状态栏图标会显示成方框。

### 4. 启动

```bash
nvim
```

进去后建议跑一下 `:checkhealth` 看是否一切正常。

---

## 目录结构

```
.
├── init.lua                 # 入口：bootstrap lazy.nvim + require core/plugins
├── install.sh               # 一键安装脚本（macOS）
├── lazy-lock.json           # 插件版本锁
├── lua/
│   ├── core/
│   │   ├── options.lua      # vim 基础选项
│   │   ├── keymaps.lua      # 全局快捷键
│   │   └── autocmds.lua     # 自动命令
│   ├── config/              # 插件具体配置（被 plugins/ 调用）
│   └── plugins/             # 插件声明（每个文件一个/一组插件）
└── doc/                     # 备忘文档
```

插件专属快捷键大多写在对应的 `plugins/*.lua` 里，避免 require 顺序问题。

---

## 插件总览

| 类别 | 插件 |
|---|---|
| 插件管理 | folke/lazy.nvim |
| 主题 | catppuccin/nvim |
| 启动页 | goolord/alpha-nvim |
| 状态栏 | nvim-lualine/lualine.nvim |
| 文件树 | nvim-neo-tree/neo-tree.nvim |
| 模糊查找 | nvim-telescope/telescope.nvim |
| 语法高亮 | nvim-treesitter/nvim-treesitter |
| LSP | mason.nvim + mason-lspconfig.nvim（gopls） |
| 补全 | hrsh7th/nvim-cmp + cmp-nvim-lsp + LuaSnip |
| 格式化 | stevearc/conform.nvim |
| Git | lewis6991/gitsigns.nvim |
| 调试 | mfussenegger/nvim-dap + dap-ui + dap-go |
| 跳转 | folke/flash.nvim |
| 同名高亮 | RRethy/vim-illuminate |
| 多光标 | mg979/vim-visual-multi |
| 注释 | numToStr/Comment.nvim |
| 自动配对 | windwp/nvim-autopairs |
| 包围编辑 | kylechui/nvim-surround |
| 快捷键提示 | folke/which-key.nvim |
| Markdown 渲染 | MeanderingProgrammer/render-markdown.nvim |

---

## 快捷键全集

> Leader = `,`，Which-key 触发 = `,,`

### 基础

| 快捷键 | 模式 | 功能 |
|---|---|---|
| `,w` | n | 保存文件 |
| `,q` | n | 关闭当前窗口 |
| `,h` | n | 清除搜索高亮 |
| `,,` | n | 打开 which-key 菜单 |
| `J` | n | 合并行（光标位置不变） |

### 窗口

| 快捷键 | 功能 |
|---|---|
| `,sv` | 垂直分屏 |
| `,sh` | 水平分屏 |
| `,sc` | 关闭当前窗口 |

### 文件树（Neo-tree）

| 快捷键 | 功能 |
|---|---|
| `,n` | 开关文件树 |
| `,cd` | 定位当前文件到文件树 |

**Neo-tree 窗口内**（标准默认键）：

| 键 | 作用 |
|---|---|
| `j / k` | 上下移动 |
| `Enter` / `l` / `w` | 打开文件 / 展开目录 |
| `h` | 折叠目录 |
| `s` / `S` | 垂直 / 水平分屏打开 |
| `t` | 新 tab 打开 |
| `a` | 新建文件或目录 |
| `r` | 重命名 |
| `d` | 删除 |
| `y` / `x` / `p` | 复制 / 剪切 / 粘贴 |
| `.` | 切换显示隐藏文件 |
| `R` | 刷新 |
| `q` | 关闭文件树 |
| `?` | 查看 Neo-tree 内置帮助 |

### 模糊查找（Telescope）

| 快捷键 | 功能 |
|---|---|
| `,ff` | 查找文件 |
| `,fg` | 全文搜索 |
| `,fr` | 最近文件 |
| `,bb` | Buffer 列表 |
| `,gr` | LSP 引用列表（也算 Telescope） |

**Picker 内**：

| 键 | 作用 |
|---|---|
| `Ctrl+j` / `Ctrl+k` | 上一个 / 下一个 |
| `Ctrl+v` / `Ctrl+s` | 垂直 / 水平分屏打开 |
| `Enter` | 当前窗口打开 |

### LSP

| 快捷键 | 功能 |
|---|---|
| `,gd` | 跳转定义 |
| `,gi` | 跳转实现 |
| `,gt` | 跳转类型定义 |
| `,gr` | 查找引用（用 Telescope 显示） |
| `,k` | Hover 文档 |
| `,rn` | 重命名 |
| `,ca` | Code Action（n / v 都可用） |

### 诊断

| 快捷键 | 功能 |
|---|---|
| `]d` | 下一个诊断（warn 及以上） |
| `[d` | 上一个诊断 |
| `,e` | 当前行诊断详情 |

### 同名引用（Illuminate）

| 快捷键 | 功能 |
|---|---|
| `]r` | 下一个同名引用 |
| `[r` | 上一个同名引用 |

### 格式化（Conform）

- 保存自动格式化（Go：`gofumpt` + `goimports`）
- `,f`：手动格式化当前文件

### Git（gitsigns）

| 快捷键 | 功能 |
|---|---|
| `]h` / `[h` | 下一个 / 上一个变更块 |
| `,gp` | 预览当前变更块 |
| `,gs` | 暂存当前变更块 |
| `,gS` | 暂存整个文件 |
| `,gR` | 撤销当前变更块的修改 |
| `,gu` | 取消暂存 |
| `,gb` | 当前行 git blame |
| `,gB` | 切换行内 blame 显示 |

> `,gr` 已分配给 LSP 引用，故不用于 git reset，避免冲突。

### 调试（nvim-dap）

| 快捷键 | 功能 |
|---|---|
| `,db` | 切换断点 |
| `,dc` | 启动 / 继续 |
| `,di` | 步入 |
| `,do` | 步过 |
| `,dO` | 步出 |
| `,dr` | 重启会话 |
| `,dq` | 终止会话 |
| `,du` | 切换 dap-ui |
| `,de` | 查看光标处变量值（n / v） |

启动调试时 dap-ui 会自动开，结束时会自动关。

### 快速跳转（Flash）

| 快捷键 | 模式 | 功能 |
|---|---|---|
| `s` | n / x / o | Flash 跳转（输入字符后选标签） |
| `S` | n / x / o | 仅在当前窗口跳转 |
| `gs` | n / x / o | 基于 Treesitter 结构跳转 |
| `r` | o | Flash remote（operator-pending） |
| `f` / `F` / `t` / `T` | n | 增强版行内字符跳转 |

### 多光标（vim-visual-multi）

| 快捷键 | 功能 |
|---|---|
| `Ctrl+n` | 选中当前词；再按选下一个相同 |
| `Ctrl+S+l` | 选中所有匹配 |
| `Ctrl+k` | 跳过当前匹配，选下一个 |
| `Ctrl+p` | 取消上一个选中 |

### 注释（Comment.nvim）

| 快捷键 | 模式 | 功能 |
|---|---|---|
| `gcc` | n | 注释 / 反注释当前行 |
| `gc` | v | 注释选中块 |

### 包围编辑（nvim-surround）

| 操作 | 说明 |
|---|---|
| `ys{motion}{char}` | 添加包围（如 `ysiw"` 给一个词加引号） |
| `ds{char}` | 删除包围 |
| `cs{old}{new}` | 修改包围（如 `cs"'` 把双引号改单引号） |

### 自动配对（autopairs）

输入 `{ ( [ ' "` 自动补尾；删除时成对删除。

### 运行

| 快捷键 | 功能 |
|---|---|
| `,rr` | 浮窗运行当前文件（Go / Python / Bash） |
| `,jrr` | Java：mvn test 当前测试类 |

### 启动页（Alpha）

进入空白 nvim 时显示启动页，页面内：

| 键 | 功能 |
|---|---|
| `f` | 查找文件 |
| `g` | 全文搜索 |
| `q` | 退出 |

---

## 常见问题

**图标显示成方框？**
没把终端字体设成 Nerd Font。把 iTerm2 / Ghostty / WezTerm 的字体改成 `JetBrainsMono Nerd Font`。

**Go 文件没有补全 / 跳转？**
进入 nvim 跑 `:Mason`，确认 `gopls` 在 Installed 列表里。如果没有，按 `i` 安装。

**保存时没自动格式化？**
检查 `gofumpt` 和 `goimports` 是否在 PATH。装方式：

```bash
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
```

**插件没加载 / 行为异常？**
跑 `:checkhealth lazy` 和 `:Lazy log` 排查；必要时 `:Lazy sync` 重新同步。
