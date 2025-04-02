return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "lua", "vim", "vimdoc", "markdown", "python", "javascript", "html", "css", "csv", "json", "yaml", "toml", "bash", "typescript", "tsx", "go", "graphql", "dockerfile", "ruby", "scss", "svelte", "vue",},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
}
