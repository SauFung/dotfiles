local configs = {
  "options",
  "autocmds",
  "keymaps",
}

local load_mod = function(mod_name)
  local mod_full_name = "config." .. mod_name
  if not package.loaded[mod_full_name] then
    require(mod_full_name)
  end
end

for _, mod in ipairs(configs) do
  load_mod(mod)
end


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = GH_MIRROR .. "folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)



-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {
    missing = true,
    colorscheme = { "habamax" }
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
  git = {
    log = { "-5" },
    timeout = 60,
    url_format = GH_MIRROR .. "%s.git",
    filter = true,
  },
  rocks = {
    enable = false,
    hererocks = false,
  }
})