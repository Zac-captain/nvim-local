return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure({
      delay = 150,
      filetypes_denylist = {
        "neo-tree",
        "NvimTree",
        "TelescopePrompt",
        "lazy",
        "help",
      },
    })
  end,
}

