return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")

    local function make_mru(count)
      local oldfiles = vim.v.oldfiles or {}
      local results = {}
      local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

      for _, file in ipairs(oldfiles) do
        if #results >= count then break end
        if vim.fn.filereadable(file) == 1 and not file:match("COMMIT_EDITMSG") then
          local icon, icon_hl = "", nil
          if devicons_ok then
            local ic, hl = devicons.get_icon(file, vim.fn.fnamemodify(file, ":e"), { default = true })
            if ic then icon = ic end
            icon_hl = hl
          end

          local idx = #results
          local key = tostring(idx)
          local fname = vim.fn.fnamemodify(file, ":t")
          local parent = vim.fn.fnamemodify(file, ":h:t")

          -- 格式: "  icon  filename        parent/"
          local left = "  " .. icon .. "  " .. fname
          local right = parent .. "/"
          local gap = 50 - #left - #right
          if gap < 2 then gap = 2 end
          local val = left .. string.rep(" ", gap) .. right

          -- 高亮位置
          local icon_start = 2
          local icon_end = icon_start + #icon
          local fname_start = icon_end + 2
          local fname_end = fname_start + #fname
          local dir_start = #val - #right
          local dir_end = #val

          local btn = {
            type = "button",
            val = val,
            on_press = function()
              vim.cmd("e " .. vim.fn.fnameescape(file))
            end,
            opts = {
              position = "center",
              shortcut = key,
              cursor = 3,
              width = 55,
              align_shortcut = "right",
              hl_shortcut = "AlphaShortcut",
              hl = {
                { icon_hl or "DevIconDefault", icon_start, icon_end },
                { "AlphaFileName", fname_start, fname_end },
                { "AlphaFilePath", dir_start, dir_end },
              },
              keymap = { "n", key, ":e " .. vim.fn.fnameescape(file) .. "<CR>", { noremap = true, silent = true } },
            },
          }
          table.insert(results, btn)
        end
      end
      return results
    end

    -- 高亮 (tokyonight 配色)
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "AlphaFileName", { fg = "#c0caf5", bold = true })
    vim.api.nvim_set_hl(0, "AlphaFilePath", { fg = "#737aa2", italic = true })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#e0af68", bold = true })
    vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#545c7e", italic = true })
    vim.api.nvim_set_hl(0, "AlphaSep", { fg = "#3b4261" })

    local header = {
      type = "text",
      val = { "", "zac-nvim", "" },
      opts = { position = "center", hl = "AlphaHeader" },
    }

    local sep = {
      type = "text",
      val = "─────────────────────────────────",
      opts = { position = "center", hl = "AlphaSep" },
    }

    local mru_files = make_mru(10)

    local mru_section = {
      type = "group",
      val = mru_files,
      opts = { spacing = 1 },
    }

    local footer = {
      type = "text",
      val = "f  find file    g  grep    q  quit",
      opts = { position = "center", hl = "AlphaFooter" },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        local bopts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "f", ":Telescope find_files<CR>", bopts)
        vim.keymap.set("n", "g", ":Telescope live_grep<CR>", bopts)
        vim.keymap.set("n", "q", ":qa<CR>", bopts)
      end,
    })

    alpha.setup({
      layout = {
        { type = "padding", val = 3 },
        header,
        sep,
        { type = "padding", val = 2 },
        mru_section,
        { type = "padding", val = 2 },
        sep,
        { type = "padding", val = 1 },
        footer,
      },
    })
  end,
}
