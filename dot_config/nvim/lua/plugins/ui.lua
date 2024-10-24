local M = {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      local onedark = require("onedark")
      onedark.setup({
        style = "darker", -- dark/darker/cool/deep/warm/warmer
        term_colors = true,
      })
      onedark.load()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "material",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globlastatus = true,
        disabled_filetypes = {
          statusline = {
            "dashboard",
            "neo-tree",
          },
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = {
      options = {
        always_show_bufferline = false,
        buffer_close_icon = "󰅖",
        modified_icon = "● ",
        close_icon = " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local logo = [[
 ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄    ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ 
█       █   █   █       █       █       █  █  █ █  █   █  █▄█  █
█  ▄▄▄▄▄█   █   █    ▄▄▄█    ▄▄▄█    ▄  █  █  █▄█  █   █       █
█ █▄▄▄▄▄█   █   █   █▄▄▄█   █▄▄▄█   █▄█ █  █       █   █       █
█▄▄▄▄▄  █   █▄▄▄█    ▄▄▄█    ▄▄▄█    ▄▄▄█  █       █   █       █
 ▄▄▄▄▄█ █       █   █▄▄▄█   █▄▄▄█   █       █     ██   █ ██▄██ █
█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄█        █▄▄▄█ █▄▄▄█▄█   █▄█
      ]]

      logo = string.rep("\n", 15) .. logo .. "\n\n"

      local conf = vim.fn.stdpath("config")

      local shortcut = {
        {
          action = "ene | startinsert",
          desc = " New file",
          icon = " ",
          key = "n",
        },

        {
          action = "Telescope find_files",
          desc = " Find file",
          icon = " ",
          key = "f",
        },

        {
          action = "Telescope oldfiles",
          desc = " Recent file",
          icon = " ",
          key = "r",
        },

        {
          action = "Telescope live_grep",
          desc = " Find Text",
          icon = " ",
          key = "g",
        },

        {
          action = "lua require('persistence').load()",
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },

        {
          action = "Neotree float " .. conf,
          desc = " Configuration",
          icon = " ",
          key = "c",
        },

        {
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
      for _, button in ipairs(shortcut) do
        button.desc = button.desc .. string.rep(" ", 40 - #button.desc)
        button.key_format = "  %s"
      end

      local bottom = function()
        local status = require("lazy").stats()
        local time = (math.floor(status.startuptime * 100 + 0.5) / 100)
        local loaded = status.loaded
        local count = status.count
        return {
          " ",
          "🚀 " .. "Startuptime: " .. time .. " ms",
          "✨ " .. "Plugins: " .. loaded .. "/" .. count .. " loaded",
        }
      end

      require("dashboard").setup({
        theme = "doom",
        config = {
          header = vim.split(logo, "\n"),
          center = shortcut,
          footer = bottom,
        },
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}

return M
