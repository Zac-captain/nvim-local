#!/usr/bin/env bash
# 一键安装脚本：在 macOS 上引导本 Neovim 配置
# 用法：克隆仓库到 ~/.config/nvim 后，运行 ./install.sh

set -euo pipefail

BLUE=$'\033[34m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
info() { printf '%s==>%s %s\n' "$BLUE"  "$RESET" "$*"; }
ok()   { printf '%s ✓ %s %s\n' "$GREEN" "$RESET" "$*"; }
warn() { printf '%s ! %s %s\n' "$YELLOW" "$RESET" "$*"; }
fail() { printf '%s ✗ %s %s\n' "$RED"   "$RESET" "$*" >&2; exit 1; }

# ── 1. 环境检查 ──────────────────────────────────────────────
[ "$(uname -s)" = "Darwin" ] || fail "目前仅支持 macOS"
command -v brew >/dev/null 2>&1 || fail "请先安装 Homebrew: https://brew.sh"

# ── 2. Neovim ≥ 0.11（本配置使用 vim.lsp.config 新 API）───────
if ! command -v nvim >/dev/null 2>&1; then
  info "安装 Neovim..."
  brew install neovim
fi
nvim_ver=$(nvim --version | awk 'NR==1{sub(/^v/,"",$2); print $2}')
if [ "$(printf '0.11\n%s\n' "$nvim_ver" | sort -V | head -1)" != "0.11" ]; then
  fail "Neovim 需要 >= 0.11（当前 $nvim_ver），请运行：brew upgrade neovim"
fi
ok "Neovim $nvim_ver"

# ── 3. 运行时依赖 ────────────────────────────────────────────
declare -a deps=(
  "git:git"
  "rg:ripgrep"
  "fd:fd"
  "go:go"
  "node:node"
)
for entry in "${deps[@]}"; do
  cmd="${entry%%:*}"; pkg="${entry##*:}"
  if command -v "$cmd" >/dev/null 2>&1; then
    ok "$cmd 已安装"
  else
    info "安装 $pkg..."
    brew install "$pkg"
  fi
done

# ── 4. Nerd Font ────────────────────────────────────────────
if ls "$HOME/Library/Fonts"/JetBrainsMonoNerd*.ttf >/dev/null 2>&1 \
   || ls /Library/Fonts/JetBrainsMonoNerd*.ttf >/dev/null 2>&1; then
  ok "JetBrainsMono Nerd Font 已安装"
else
  info "安装 JetBrainsMono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font
fi

# ── 5. 同步插件（lazy.nvim 首次会自举克隆）────────────────────
info "同步插件（首次需要从 GitHub 下载，请稍候）..."
nvim --headless "+Lazy! sync" +qa

plugin_count=$(ls -1 "$HOME/.local/share/nvim/lazy" 2>/dev/null | wc -l | tr -d ' ')
ok "已安装 $plugin_count 个插件"

# ── 6. Mason: 安装 gopls ────────────────────────────────────
if [ -x "$HOME/.local/share/nvim/mason/bin/gopls" ]; then
  ok "gopls 已安装：$("$HOME/.local/share/nvim/mason/bin/gopls" version | head -1)"
else
  info "安装 gopls（Mason 异步下载，最多等 90 秒）..."
  nvim --headless "+MasonInstall gopls" "+sleep 90" +qa
  if [ -x "$HOME/.local/share/nvim/mason/bin/gopls" ]; then
    ok "gopls 已安装：$("$HOME/.local/share/nvim/mason/bin/gopls" version | head -1)"
  else
    warn "gopls 自动安装失败，请进入 nvim 后手动运行：:MasonInstall gopls"
  fi
fi

# ── 完成 ─────────────────────────────────────────────────────
cat <<EOF

${GREEN}=== 安装完成 ===${RESET}

下一步：
  1. 把终端字体设置为 "JetBrainsMono Nerd Font"（否则图标显示为方块）
  2. 运行 ${BLUE}nvim${RESET}
  3. 在 nvim 内运行 ${BLUE}:checkhealth${RESET} 排查任何剩余问题

EOF
