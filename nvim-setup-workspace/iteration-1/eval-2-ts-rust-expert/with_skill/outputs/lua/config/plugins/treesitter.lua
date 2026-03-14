-- lua/config/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "typescript",
        "tsx",
        "rust",
        "lua",
        "json",
        "markdown",
        -- always useful
        "vim",
        "vimdoc",
        "query",
      },
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
