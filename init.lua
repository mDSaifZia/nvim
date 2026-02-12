-- config inspired by Radley E. Sidwell-lewis
-- https://github.com/radleylewis/nvim-lite/blob/master/init.lua

vim.cmd.colorscheme("sorbet")
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.cursorline=true
vim.opt.wrap=false
vim.opt.scrolloff=10
vim.opt.sidescrolloff=8
vim.opt.virtualedit="all"


vim.opt.smarttab=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.smartindent=true
vim.opt.autoindent=true

vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.hlsearch=false
vim.opt.incsearch=true

vim.opt.termguicolors=true
vim.opt.signcolumn="yes"
vim.opt.showmatch=true
vim.opt.matchtime=2
vim.opt.cmdheight=1
vim.opt.completeopt="menuone,noinsert,noselect"
vim.opt.pumheight=10
vim.opt.winblend=0
vim.opt.conceallevel=0
vim.opt.concealcursor=""
vim.opt.lazyredraw=true
vim.opt.synmaxcol=300
vim.opt.fillchars={eob=" "}

local undodir=vim.fn.stdpath('config') .. '/undodir'
if vim.fn.isdirectory(undodir)==0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.backup=false
vim.opt.writebackup=false
vim.opt.swapfile=false
vim.opt.undofile=true
vim.fn.mkdir(undodir,'p')
vim.opt.undodir=undodir
vim.opt.updatetime=300
vim.opt.timeoutlen=500
vim.opt.ttimeoutlen=0
vim.opt.autoread=true
vim.opt.autowrite=false

vim.opt.hidden=true
vim.opt.errorbells=false
vim.opt.backspace="indent,eol,start"
vim.opt.autochdir=false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection="exclusive"
vim.opt.modifiable=true
vim.opt.encoding="UTF-8"
vim.opt.guicursor = {
    "n-v-c:block",
    "i-ci-ve:block",
    "r-cr:hor20",
    "o:hor50",
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "sm:block-blinkwait175-blinkoff150-blinkon175"
}

vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldlevel=99

vim.opt.splitbelow=true
vim.opt.splitright=true

vim.g.mapleader=" "
vim.g.maplocalleader=" "

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
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

vim.keymap.set("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

local augroup=vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group=augroup,
    callback=function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group=augroup,
    callback=function()
        local mark=vim.api.nvim_buf_get_mark(0, '"')
        local lcount=vim.api.nvim_buf_line_count(0)
        local line=mark[1]
        local ft=vim.bo.filetype
        if line>0 and line<=lcount
            and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft)==-1
            and not vim.o.diff then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    group=augroup,
    callback = function()
        vim.cmd('bprevious')
        vim.cmd('bd! #')
    end,
})

vim.opt.wildmenu=true
vim.opt.wildmode="longest:full,full"
vim.opt.wildignore:append({"*.o", "*.obj", "*.pyc", "*.class", "*.jar"})

vim.opt.diffopt:append("linematch:60")

vim.opt.redrawtime=10000
vim.opt.maxmempattern=20000

-- inspired by cmuratori's emacs C++ config
local function find_corresponding_file()
    local current_file=vim.fn.expand('%')
    local base_name=vim.fn.expand('%:r')
    local corresponding_file=nil

    if current_file:match('%.c$') then
        corresponding_file=base_name .. '.h'
    elseif current_file:match('%.h$') then
        if vim.fn.filereadable(base_name .. '.c') == 1 then
            corresponding_file=base_name .. '.c'
        else
            corresponding_file=base_name .. '.cpp'
        end
    elseif current_file:match('%.hin$') then
        corresponding_file=base_name .. '.cin'
    elseif current_file:match('%.cin$') then
        corresponding_file=base_name .. '.hin'
    elseif current_file:match('%.cpp$') then
        corresponding_file=base_name .. '.h'
    end

    if corresponding_file then
        vim.cmd('edit ' .. vim.fn.fnameescape(corresponding_file))
    else
        print('Unable to find a corresponding file')
    end
end

vim.keymap.set('n', '<leader>a', find_corresponding_file, { desc = 'Switch to corresponding file' })

vim.keymap.set('n', 'gd', '<C-]>', { desc = 'Jump to tag definition' })
vim.keymap.set('n', 'gb', '<C-t>', { desc = 'Jump back from tag' })
vim.keymap.set('n', 'g]', 'g]', { desc = 'List all tags' })
