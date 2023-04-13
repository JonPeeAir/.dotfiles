return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.oxocarbon" },
  {
    import = "astrocommunity.colorscheme.everforest",
    opts = {
      everforest_background = "hard",
      everforest_transparent_background = 2,
      everforest_sign_column_background = "grey",
      everforest_ui_contrast = "high",
    },
  },
  { import = "astrocommunity.colorscheme.kanagawa" },
  { import = "astrocommunity.colorscheme.tokyonight" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
