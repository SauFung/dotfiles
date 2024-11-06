if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = WIN32YANK .. " -i --crlf",
      ["*"] = WIN32YANK .. " -i --crlf",
    },
    paste = {
      ["+"] = WIN32YANK .. " -o --lf",
      ["*"] = WIN32YANK .. " -o --lf",
    },
    cache_enable = false,
  }
end

local o = vim.opt

vim.g.have_nerd_font = true

o.number = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true

o.cursorline = true

o.list = true
o.listchars = {
  trail = "_",
}

o.termguicolors = true

o.clipboard = "unnamedplus"

o.scrolloff = 5

o.confirm = true

o.showmode = false

o.ignorecase = true
