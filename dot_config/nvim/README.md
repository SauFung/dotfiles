# 使用说明

## Requirements

- Neovim latest version
- Git
- Nerd font
- fd (for `Telescope find_files`)
- ripgrep (for `Telescope live_grep`)
- luarocks (for LSP `pyright`)

## 文件结构
```bash
.
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   └── plugins
│       ├── cmp.lua
│       ├── editor.lua
│       ├── file.lua
│       ├── lsp.lua
│       ├── treesitter.lua
│       └── ui.lua
├── README.md
└── stylua.toml
```


## 移动

- `f{char}`：移动到下一个指定字符
- `F{char}`：移动到上一个指定字符
- `t{char}`：移动到下一个指定字符前一位
- `T{char}`：移动到上一个指定字符后一位
- `f/F` 操作，按 `f` 移动下一匹配值，按 `F` 移动上一匹配值
- `t/T` 操作，按 `t` 移动下一匹配值，按 `T` 移动上一匹配值
- 涉及插件：`folke/flash.nvim`
> 使用 `;` 继续移动到下一匹配值
> 使用 `,` 继续移动到上一匹配值
> 使用 `<Esc>` 取消操作

## 编辑

### 修改包围
- 涉及插件：`kylechui/nvim-surround`
操作说明：
- 新增：`ys{motion}{char}`
- 删除：`ds{char}`
- 修改：`cs{target}{replacement}`


## File Manager
- 涉及插件：`nvim-neo-tree/neo-tree.nvim`
- 打开：`:Neotree`/`:Neotree <path>`（打开当前目录或打开指定目录）
- 按键：
    - `?`：打开帮助
    - `H`：切换显示隐藏文件
    - `q`：关闭 Neotree
    - `r`：重命名
    - `a`：新增文件
    - `A`：新增文件夹
    - `d`：删除
    - `m`：移动
    - `p`：粘贴
    - `P`：切换打开文件预览
    - `<Esc>`：取消操作


## 宏操作
- `q{register}`：录制宏
- `@{register}`：执行宏
- `@@`：执行上一次宏
- `:reg`：查看所有寄存器
- `:reg {register}`：查看指定寄存器


register：
- 可选用的寄存器
    - `0-9`
    - `a-z`
    - `"`
- 大写 `A-Z` 可以添加对应小写字母的附加操作



## Mason

### Linter

- LSP 默认有 linter 功能，可不安装










