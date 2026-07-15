return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local languages = {
        "bash",
        "css",
        "go",
        "gomod",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "typescript",
        "typescriptreact",
        "yaml",
      }

      require("nvim-treesitter").setup()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
