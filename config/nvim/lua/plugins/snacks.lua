return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- Show hidden files (dotfiles) in most pickers
        ignored = true, -- Show gitignored files (e.g. .env) in most pickers
        sources = {
          files = { hidden = true },
          explorer = { hidden = true, ignored = true }, -- never hide anything in the file explorer
        },
      },
    },
  },
}
