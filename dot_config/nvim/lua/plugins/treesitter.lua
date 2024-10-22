local M = {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").prefer_git = true

      for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
        config.install_info.url = config.install_info.url:gsub("https://github.com/", GH_MIRROR)
      end

      require("nvim-treesitter.configs").setup({

        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
        },

        sync_install = true,

        auto_install = true,

        highlight = {
          enable = true,
        },

        indentation = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- 自动选择
            node_incremental = "grn", -- 扩大选择范围
            scope_incremental = "grc", -- 选择整个代码段
            node_decremental = "grm", -- 减少选择范围
          },
        },

        textobjects = {
          -- 选择文本对象
          select = {
            enable = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
            },
          },

          -- 交换参数
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },

          move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]p"] = "@parameter.outer",
            },

            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]P"] = "@parameter.outer",
            },

            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[p"] = "@parameter.outer",
            },

            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[P"] = "@parameter.outer",
            },
          },
        },
      })
    end,
  },
}

return M
