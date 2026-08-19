-- Ctrl+j / Ctrl+k to cycle the completion suggestion list (vim-idiomatic; no terminal interception).
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
  },
}
