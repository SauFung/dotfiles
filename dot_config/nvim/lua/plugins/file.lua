local M = {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        source_selector = {
          winbar = false,
          statusline = false,
        },
        close_if_last_window = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
          },
        },
        filesystem = {
          hijack_netrw_behavior = "open_default",
        },
      })
    end,
  },
}

return M
