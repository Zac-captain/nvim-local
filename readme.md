# Neovim 配置说明（Go）

本文件用于说明当前 **Neovim（以 Go 开发为主）** 的配置结构、插件组成及快捷键约定。

---

## 一、基本约定

- 插件管理器：**lazy.nvim**
- Leader 键：`,`（逗号）
- Which-key 触发键：`,,`
- 字体：JetBrainsMono Nerd Font
- 当前主线：
  - Go 后端开发
  - 通用文本 / 配置编辑
- 已明确不用：
  - neotest
  - treesitter（语法高亮主要依赖 colorscheme + LSP）

---

## 二、插件总览（当前实际使用）

### 插件管理

- **folke/lazy.nvim**  
  插件安装、更新、懒加载管理

命令：
- `:Lazy` 打开插件管理界面

---

### 文件树（目录浏览）

> **已从 NvimTree 迁移至 Neo-tree**

- **nvim-neo-tree/neo-tree.nvim**
- nvim-lua/plenary.nvim
- nvim-tree/nvim-web-devicons
- MunifTanjim/nui.nvim

用途：
- 左侧目录树
- 启动时自动打开
- 自动定位并展开到当前文件
- 更稳定的窗口与 root 行为

说明：
- 不再使用 `nvim-tree.nvim`
- Neo-tree 作为独立 UI 文件管理器使用

---

### LSP（代码智能）

- neovim/nvim-lspconfig
- williamboman/mason.nvim
- williamboman/mason-lspconfig.nvim

用途：
- 跳转定义 / 引用
- Hover 文档
- 重命名
- Code Action

Go 使用：
- gopls

---

### 自动补全

- hrsh7th/nvim-cmp
- hrsh7th/cmp-nvim-lsp
- L3MON4D3/LuaSnip
- saadparwaiz1/cmp_luasnip

用途：
- LSP 补全
- 代码片段补全

---

### 格式化

- **stevearc/conform.nvim**

Go 常用：
- gofmt
- goimports（如已配置）

---

### 查找 / 导航

- **nvim-telescope/telescope.nvim**
- nvim-lua/plenary.nvim

用途：
- 文件查找
- 全文搜索
- Buffer / 历史文件跳转

---

### Git

- **lewis6991/gitsigns.nvim**

用途：
- 行内 diff
- blame
- hunk 操作

---

### UI

- **nvim-lualine/lualine.nvim**（状态栏）
- **folke/which-key.nvim**（快捷键提示）
- **folke/tokyonight.nvim**（主题）

---

### 编辑增强

- **numToStr/Comment.nvim**（注释）
- **windwp/nvim-autopairs**（自动括号）

---

## 三、快捷键全集

### Leader 规则

- Leader：`,`
- Which-key：`,,`

---

### 基础操作

| 快捷键 | 功能 |
|------|------|
| `,w` | 保存文件 |
| `,q` | 关闭当前窗口 |
| `,h` | 取消搜索高亮 |
| `J`  | 合并下一行但保持光标位置 |

---

### 窗口管理

| 快捷键 | 功能 |
|------|------|
| `,sv` | 垂直分屏 |
| `,sh` | 水平分屏 |
| `,sc` | 关闭当前窗口 |

---

### LSP（代码导航）

| 快捷键 | 功能 |
|------|------|
| `,gd` | 跳转定义 |
| `,gi` | 跳转实现 |
| `,gt` | 跳转类型定义 |
| `,gr` | 查引用 |
| `,k`  | Hover 文档 |
| `,rn` | 重命名 |
| `,ca` | Code Action |

---

### Neo-tree（目录树）

| 快捷键 | 功能 |
|------|------|
| `,n` | 打开 Neo-tree |
| `,N` | 关闭 Neo-tree |
| `,f` | 在目录树中定位当前文件 |
| `q`  | 在树窗口中关闭 Neo-tree |

目录树内常用操作（Neo-tree 默认）：

- `j / k`：上下移动
- `Enter / l / w`：打开文件 / 展开目录
- `h`：折叠目录
- `s`：竖分屏打开
- `S`：横分屏打开
- `a`：新建文件 / 目录
- `r`：重命名
- `d`：删除
- `y / x / p`：复制 / 剪切 / 粘贴
- `?`：查看 Neo-tree 内置帮助

> 说明：  
> Neo-tree 是“文件管理器语义”，快捷键与 Vim 文本编辑模式不同，属正常设计。

---

### Telescope（模糊查找）

| 快捷键 | 功能 |
|------|------|
| `,ff` | 查找文件 |
| `,fr` | 最近文件 |
| `,fg` | 全文搜索 |
| `,bb` | Buffer 列表 |

Picker 内操作：

- `Ctrl+j`：下一个
- `Ctrl+k`：上一个
- `Ctrl+v`：垂直分屏打开
- `Ctrl+s`：水平分屏打开
- `Enter`：当前窗口打开

---

### Git（gitsigns）

| 快捷键 | 功能 |
|------|------|
| `]h` | 下一个 hunk |
| `[h` | 上一个 hunk |
| `,gp` | 预览 hunk |
| `,gs` | 暂存 hunk |
| `,gS` | 暂存整个文件 |
| `,gu` | 撤销暂存 |
| `,gb` | 查看当前行 blame |
| `,gB` | 切换 inline blame |

说明：
- `,gr` 已保留给 LSP 引用，不用于 git reset，避免冲突

---

### 注释（Comment.nvim）

| 操作 | 功能 |
|----|----|
| `gcc` | 注释当前行 |
| `gc`（可视模式） | 注释选中代码块 |

---

### 自动括号

- 输入 `{ ( [ ' "` 自动补全
- 删除时成对删除

---

### Which-key

| 快捷键 | 功能 |
|------|------|
| `,,` | 显示 Leader 快捷键菜单 |

---





### Neo-tree（目录树）

> 当前使用 **Neo-tree** 作为唯一目录树插件  
> Neo-tree 是“文件管理器语义”，快捷键与 Vim 文本编辑模式不同，属正常设计。

---

#### 全局快捷键（Leader）

| 快捷键 | 功能 |
|------|------|
| `,n` | 打开 Neo-tree（左侧） |
| `,N` | 关闭 Neo-tree |
| `,f` | 在 Neo-tree 中定位当前文件 |

说明：
- `,n` / `,N` 明确区分 **打开 / 关闭**，不使用 toggle，避免状态不一致
- `,f` 用于手动 reveal 当前文件（不自动跟随 buffer）

---

#### Neo-tree 窗口内快捷键（默认）

##### 基础导航

| 快捷键 | 功能 |
|------|------|
| `j / k` | 上下移动 |
| `h` | 折叠目录 / 返回上级 |
| `l` | 展开目录 / 打开文件 |
| `Enter` | 打开文件 / 展开目录 |
| `w` | 打开文件 / 展开目录（等价于 Enter） |

> 说明：  
> `w` 在 Neo-tree 中表示 **open**，不是 Vim 的 word-motion  
> 这是 Neo-tree 的设计选择（文件管理器语义）

---

##### 打开方式（分屏 / Tab）

| 快捷键 | 功能 |
|------|------|
| `s` | 垂直分屏打开 |
| `S` | 水平分屏打开 |
| `t` | 新 tab 打开 |

---

##### 文件 / 目录操作

| 快捷键 | 功能 |
|------|------|
| `a` | 新建文件 / 目录 |
| `r` | 重命名 |
| `d` | 删除 |
| `y` | 复制 |
| `x` | 剪切 |
| `p` | 粘贴 |

---

##### 显示 / 刷新

| 快捷键 | 功能 |
|------|------|
| `.` | 显示 / 隐藏隐藏文件 |
| `R` | 刷新目录树 |
| `z` | 折叠所有目录 |

---

##### 退出 / 帮助

| 快捷键 | 功能 |
|------|------|
| `q` | 关闭 Neo-tree 窗口 |
| `?` | 显示 Neo-tree 内置帮助 |

> 提示：  
> 在 Neo-tree 窗口按 `?`，可查看**当前版本真实生效的快捷键列表**

---

#### 使用约定说明

- Neo-tree 仅用于：
  - 浏览目录
  - 打开 / 新建 / 重命名文件
- 不在 Neo-tree 窗口进行文本编辑
- 打开文件后立即回到代码窗口

若需完全 Vim 风格（文件即 buffer），可考虑 `oil.nvim`（未启用）。
