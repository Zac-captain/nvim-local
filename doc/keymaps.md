# Neovim 快捷键速查表

> Leader 键: `,`
> 按 `,,` 打开 which-key 菜单查看所有 leader 快捷键

---

## 基础操作

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,w` | 保存文件 | keymaps.lua |
| `,q` | 退出窗口 | keymaps.lua |
| `,h` | 清除搜索高亮 | keymaps.lua |
| `,,` | 打开 which-key 菜单 | whichkey.lua |

## 窗口管理

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,sv` | 垂直分屏 | keymaps.lua |
| `,sh` | 水平分屏 | keymaps.lua |
| `,sc` | 关闭当前窗口 | keymaps.lua |

## 文件树 (Neo-tree)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,n` | 开关文件树 | keymaps.lua |
| `,cd` | 定位当前文件 | keymaps.lua |

**文件树内部快捷键** (光标在 Neo-tree 窗口中时):

| 快捷键 | 功能 |
|--------|------|
| `a` | 新建文件/目录 (末尾加 `/` 建目录) |
| `d` | 删除 |
| `r` | 重命名 |
| `c` | 复制到... |
| `m` | 移动到... |
| `y` | 复制文件名 |
| `<CR>` / `o` | 打开文件 / 展开目录 |
| `<BS>` | 返回上级目录 |
| `P` | 预览 (不跳转光标) |
| `s` | 垂直分屏打开 |
| `S` | 水平分屏打开 |
| `t` | 新 tab 打开 |
| `z` | 折叠全部 |
| `H` | 显示/隐藏隐藏文件 |
| `R` | 刷新文件树 |
| `q` | 关闭 Neo-tree |
| `?` | 查看所有快捷键帮助 |

## 搜索 (Telescope)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,ff` | 按文件名查找 | keymaps.lua |
| `,fg` | 全文内容搜索 (rg) | keymaps.lua |
| `,fr` | 最近打开的文件 | keymaps.lua |
| `,bb` | 已打开的缓冲区 | keymaps.lua |

## LSP 导航

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,gd` | 跳转到定义 | keymaps.lua |
| `,gr` | 查找引用 (Telescope) | keymaps.lua |
| `,gi` | 跳转到实现 | keymaps.lua |
| `,gt` | 跳转到类型定义 | keymaps.lua |

> 注: 目前只配了 gopls, LSP 跳转仅在 Go 中可用

## LSP 辅助

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,k` | 悬浮文档 | keymaps.lua |
| `,rn` | 重命名符号 | keymaps.lua |
| `,ca` | Code Action (n/v 模式) | keymaps.lua |

## 编辑增强

| 快捷键 | 模式 | 功能 | 来源 |
|--------|------|------|------|
| `J` | n | 合并行, 保持光标位置 | keymaps.lua |
| `gcc` | n | 注释/取消注释当前行 | Comment.nvim |
| `gc` | v | 注释/取消注释选中区域 | Comment.nvim |

## 包裹操作 (nvim-surround)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `ys{motion}{char}` | n | 添加包裹, 如 `ysiw"` 给单词加双引号 |
| `ds{char}` | n | 删除包裹, 如 `ds"` 删除双引号 |
| `cs{old}{new}` | n | 替换包裹, 如 `cs"'` 双引号换单引号 |
| `S{char}` | v | 给选中内容加包裹 |

## 快速跳转 (Flash)

| 快捷键 | 模式 | 功能 | 来源 |
|--------|------|------|------|
| `s` | n/x/o | 快速字符/单词跳转 | flash.lua |
| `S` | n/x/o | 当前窗口跳转 | flash.lua |
| `gs` | n/x/o | 基于语法结构跳转 (treesitter) | flash.lua |
| `r` | o | 远程跳转 (operator 模式) | flash.lua |
| `f/F/t/T` | n | 增强版行内跳转 | flash.lua |

## 诊断跳转

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `]d` | 跳到下一个诊断 (错误/警告) | keymaps.lua |
| `[d` | 跳到上一个诊断 | keymaps.lua |
| `,e` | 查看当前行诊断详情 (浮窗) | keymaps.lua |

## 引用跳转 (Illuminate)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `]r` | 跳到下一个同名引用 | keymaps.lua |
| `[r` | 跳到上一个同名引用 | keymaps.lua |

## 多光标 (vim-visual-multi)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `Ctrl+n` | 选中当前词, 再按选下一个 | multicursor.lua |
| `Ctrl+Shift+l` | 选中所有匹配 | multicursor.lua |
| `Ctrl+k` | 跳过当前, 选下一个 | multicursor.lua |
| `Ctrl+p` | 取消当前选中 | multicursor.lua |

## Git (gitsigns)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `]h` | 跳到下一个变更块 | gitsigns.lua |
| `[h` | 跳到上一个变更块 | gitsigns.lua |
| `,gp` | 预览当前变更块 | gitsigns.lua |
| `,gs` | 暂存当前变更块 (stage) | gitsigns.lua |
| `,gS` | 暂存整个文件 | gitsigns.lua |
| `,gR` | 撤销当前变更块 (reset) | gitsigns.lua |
| `,gu` | 撤销暂存 (undo stage) | gitsigns.lua |
| `,gb` | 查看当前行作者 (blame) | gitsigns.lua |
| `,gB` | 切换行尾 blame 信息 | gitsigns.lua |

## 调试 (DAP)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,db` | 切换断点 | dap.lua |
| `,dc` | 启动/继续 | dap.lua |
| `,di` | 步入 (step into) | dap.lua |
| `,do` | 步过 (step over) | dap.lua |
| `,dO` | 步出 (step out) | dap.lua |
| `,dr` | 重启 | dap.lua |
| `,dq` | 终止 | dap.lua |
| `,du` | 切换调试 UI | dap.lua |
| `,de` | 查看变量值 (n/v 模式) | dap.lua |

## 测试 (neotest)

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,tn` | 运行最近的测试 | neotest.lua |
| `,tf` | 运行当前文件 | neotest.lua |
| `,tp` | 运行当前包 | neotest.lua |
| `,tA` | 运行整个项目 (go test ./...) | neotest.lua |
| `,ts` | 停止运行 | neotest.lua |
| `,tr` | 重跑上一次 | neotest.lua |
| `,to` | 打开当前用例输出 | neotest.lua |
| `,tO` | 切换全局输出面板 | neotest.lua |
| `,tt` | 切换测试树 (summary) | neotest.lua |
| `,tj` | 跳到下一个失败 | neotest.lua |
| `,tJ` | 跳到上一个失败 | neotest.lua |
| `,ta` | 附加到运行 (attach) | neotest.lua |

## 运行

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `,rr` | 运行当前文件 (go/python/sh) | keymaps.lua |
| `,jrr` | Java: 运行测试类 (mvn test) | keymaps.lua |

## 补全 (nvim-cmp)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Tab` | i | 下一个补全项 / 展开片段 / 跳到下一占位 |
| `Shift+Tab` | i | 上一个补全项 / 跳到上一占位 |
| `Enter` | i | 确认补全 (自动选中第一项) |
| `Ctrl+Space` | i | 手动触发补全 |

## 格式化

| 触发 | 功能 | 来源 |
|------|------|------|
| 保存时自动触发 | conform.nvim 自动格式化 | format.lua |
