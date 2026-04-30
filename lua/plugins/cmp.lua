return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("config.cmp").setup()
    end,
  },
}
