local M = {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason = require("mason")
      local mason_tool_installer = require("mason-tool-installer")
      local lspconfig = require("lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        github = {
          download_url_template = GH_MIRROR .. "%s/releases/download/%s/%s",
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          -- lsp
          "lua-language-server",
          "cmake-language-server",
          "pyright",
          "clangd",

          -- linter
          -- "luacheck",

          -- formatter
          "stylua",
        },
        auto_update = false,
        run_on_start = true,
      })

      lspconfig.lua_ls.setup({
        on_init = function(client)
          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      lspconfig.clangd.setup({})
      lspconfig.cmake.setup({})
      lspconfig.pyright.setup({})
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufReadPre",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- lua = { "luacheck" },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      show_dirname = false,
      kinds = {
        File = "",
        Module = "",
        Namespace = "",
        Package = "",
        Class = "",
        Method = "",
        Property = "",
        Field = "",
        Constructor = "",
        Enum = "",
        Interface = "",
        Function = "󰡱",
        Variable = "",
        Constant = "",
        String = "󰅳",
        Number = "",
        Boolean = "",
        Array = "󰅨",
        Object = "",
        Key = "",
        Null = "󰟢",
        EnumMember = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      },

      theme = {
        basename = { bold = true },
        context_file = { link = "Tag" },
        context_module = { link = "Exception" },
        context_namespace = { link = "Include" },
        context_package = { link = "Label" },
        context_class = { link = "Include" },
        context_method = { link = "Function" },
        context_property = { link = "@property" },
        context_field = { link = "@field" },
        context_constructor = { link = "@constructor" },
        context_enum = { link = "@number" },
        context_interface = { link = "Type" },
        context_function = { link = "Function" },
        context_variable = { link = "@variable" },
        context_constant = { link = "Constant" },
        context_string = { link = "String" },
        context_number = { link = "Number" },
        context_boolean = { link = "Boolean" },
        context_array = { link = "Type" },
        context_object = { link = "Type" },
        context_key = { link = "Constant" },
        context_null = { link = "Constant" },
        context_enum_member = { link = "Number" },
        context_struct = { link = "Type" },
        context_event = { link = "Constant" },
        context_operator = { link = "Operator" },
        context_type_parameter = { link = "Type" },
      },
    },
  },
}

return M
