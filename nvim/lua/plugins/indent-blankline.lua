return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",

    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = true,
      },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "neo-tree",
          "terminal",
        },
      },
    },
  },
}
