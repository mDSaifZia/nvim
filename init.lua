-- config inspired by Radley E. Sidwell-lewis + casey's .emacs
-- >> https://github.com/radleylewis/nvim-lite/blob/master/init.lua
-- >> https://github.com/ecxr/handmadehero/blob/master/misc/.emacs

vim.cmd.colorscheme("catppuccin")
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.cursorline=true
vim.opt.wrap=false
vim.opt.scrolloff=10
vim.opt.sidescrolloff=8

vim.opt.smarttab=true
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.autoindent=true

vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.hlsearch=false
vim.opt.incsearch=true

vim.opt.termguicolors=true
vim.opt.signcolumn="yes"
vim.opt.matchtime=2
vim.opt.cmdheight=1
vim.opt.completeopt =''
vim.opt.complete='.,w,b,u,t'
vim.opt.winblend=0
vim.opt.conceallevel=0
vim.opt.concealcursor=""
vim.opt.synmaxcol=300
vim.opt.fillchars={eob=" "}

vim.opt.backup=false
vim.opt.writebackup=false
vim.opt.swapfile=false
vim.opt.undofile=false
vim.opt.timeoutlen=500
vim.opt.ttimeoutlen=0
vim.opt.autoread=true
vim.opt.autowrite=false

vim.opt.hidden=true
vim.opt.errorbells=false
vim.opt.backspace="indent,eol,start"
vim.opt.autochdir=true
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection="exclusive"
vim.opt.modifiable=true
vim.opt.encoding="UTF-8"
vim.opt.guicursor = "a:block-blinkon0"

vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldlevel=99

vim.opt.splitbelow=true
vim.opt.splitright=true

vim.g.mapleader=" "
vim.g.maplocalleader=" "

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("n", "n", "nzzzv", {desc = "Next search result (centered)" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config" })    
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<leader>t", ":term<CR>", {desc = "Open terminal shortcut" })

vim.keymap.set('i', '<Tab>',   '<C-n>', { noremap = true })
vim.keymap.set('i', '<S-Tab>', '<C-p>', { noremap = true })

local augroup=vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group=augroup,
    callback=function()
        vim.highlight.on_yank()
    end,
})

vim.opt.wildmenu=true
vim.opt.wildmode=longest,full
vim.opt.wildignore:append({"*.o", "*.obj", "*.pyc", "*.class", 
"*.jar", "*.ilk", "*.exe", "*.pdb",
"*.rdbg", "*.obj", "*.map"})

vim.opt.diffopt:append("linematch:60")

vim.opt.maxmempattern=20000

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {"c", "cpp"},
    callback = function()
        vim.opt_local.cindent = true
        vim.opt_local.cinoptions = {
            "l1", ":4", "g0", "h-4", "N-s",
            "(0", "Ws", "k0", "t0", "+4",
            "c4", "C1", "}0", "w1", "m1", "j1",
        }
        vim.opt_local.smartindent = false

        vim.keymap.set('n', '<leader>ct', function()
            vim.cmd('!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .')
            vim.notify('[init.lua] Tags generated', vim.log.levels.INFO)
        end, { buffer = true, desc = 'Generate ctags' })

        vim.keymap.set('n', 'gd',   '<C-]>',        { buffer = true, desc = 'Jump to tag definition' })
        vim.keymap.set('n', 'gb',   '<C-t>',        { buffer = true, desc = 'Jump back from tag' })
        vim.keymap.set('n', 'g]',   'g]',           { buffer = true, desc = 'List all tags' })

        -- Need to setup quickfix (makeprg) to work like Emacs Compilation Mode for this to be useful
        -- vim.keymap.set('n', '<A-n>', ':cnext<CR>',  { buffer = true, desc = 'Next error' })
        -- vim.keymap.set('n', '<A-p>', ':cprev<CR>',  { buffer = true, desc = 'Previous error' })
        -- vim.keymap.set('n', '<A-f>', ':cfirst<CR>', { buffer = true, desc = 'First error' })
    end,
}
