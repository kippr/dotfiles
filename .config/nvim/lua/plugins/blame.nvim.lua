return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {
          colors = { 
                    -- solarized colors
                    "#002b36", -- $base03:
                    "#073642", -- $base02:
                    "#586e75", -- $base01:
                    "#657b83", -- $base00:
                    "#839496", -- $base0:
                    -- "#93a1a1", -- $base1:
                    -- "#eee8d5", -- $base2:
                    -- "#fdf6e3", -- $base3:
                    "#b58900", -- $yellow:
                    "#cb4b16", -- $orange:
                    "#dc322f", -- $red:
                    "#d33682", -- $magenta:
                    "#6c71c4", -- $violet:
                    "#268bd2", -- $blue:
                    "#2aa198", -- $cyan:
                    "#859900", -- $green:
                },
      }
    end,
    opts = {
      blame_options = { '-w' },
    },
  },
}
