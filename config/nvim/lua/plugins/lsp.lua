-- Disable LSP inlay hints (the faded inline type/parameter "placeholder" text).
return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
  },
}
