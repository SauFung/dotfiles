local M = {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      local onedark = require("onedark")
      onedark.setup({
        style = "darker", -- dark/darker/cool/deep/warm/warmer
        term_colors = true,
        code_style = {
          keywords = "bold",
          functions = "bold",
          comments = "italic",
        },
      })

      onedark.load()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lsp_name = function()
        local clients = vim.lsp.get_clients()
        local client_names = {}
        if not next(clients) then
          return "󱚢 " .. "No Active Lsp"
        end

        for _, client in ipairs(clients) do
          if not client_names[client.name] then
            table.insert(client_names, client.name)
          end
        end
        return "󰚩 " .. client_names[1]
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "material",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          globlastatus = true,
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "neo-tree",
            },
          },
        },

        sections = {
          lualine_a = {
            {
              "mode",
              icons_enabled = true,
              icon = { "", color = { gui = "NONE" } },
              color = { gui = "bold" },
            },
          },
          lualine_c = {
            {
              "filetype",
              colored = true,
              icon_only = true,
              padding = { left = 1, right = 0 },
              separator = { left = "", right = "" },
            },
            {
              "filename",
              separator = { left = "", right = "" },
              padding = { left = 0, right = 0 },
            },
            {
              "%=",
            },
            {
              lsp_name,
              color = { fg = "#61AFEF", gui = "NONE" },
            },
          },
          lualine_x = {
            {
              "encoding",
              fmt = string.upper,
              padding = { left = 1, right = 0 },
            },
            {
              "fileformat",
              fmt = string.upper,
              icons_enabled = false,
              color = { fg = "#82AAFF", gui = "bold" },
            },
          },
        },
      })
    end,
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
    submodules = false,
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
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
          dir = vim.fn.stdpath("state") .. "/sessions/",
        },
      },
    },
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

      logo = string.rep("\n", 12) .. logo .. "\n\n"

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
          action = "lua require('persistence').load({last = true})",
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
