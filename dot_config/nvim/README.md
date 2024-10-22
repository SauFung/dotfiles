# 使用说明

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

## 编辑

### 修改包围
- 涉及插件：`kylechui/nvim-surround`
操作说明：
- 新增：`ys{motion}{char}`
- 删除：`ds{char}`
- 修改：`cs{target}{replacement}`



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










