return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    filter = "classic",
    transparent_background = false,
    terminal_colors = true,
    devicons = true,
  },
  config = function(_, opts)
    require("monokai-pro").setup(opts)
    vim.cmd.colorscheme("monokai-pro")
  end,
}

