vim.cmd [[source ~/.vimrc]]

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
  hijack_cursor = true,
  renderer = {
    indent_markers = {
      enable = true,
      inline_arrows = false,
    },
    icons = {
      glyphs = {
        git = {
          unstaged = "m",
          renamed = "r",
          untracked = "u",
          deleted = "d",
          staged = "s",
        },
      },
    },
  },
}
vim.cmd [[nmap <F2> :NvimTreeFocus<CR>]]
vim.cmd [[imap <F2> <Esc>:NvimTreeFocus<CR>]]

vim.cmd [[nmap <F3> :NvimTreeToggle<CR>]]
vim.cmd [[imap <F3> <Esc>:NvimTreeToggle<CR>]]

vim.cmd [[nmap <F4> :tabnew<CR>:NvimTreeOpen<CR>]]
vim.cmd [[imap <F4> <Esc>:tabnew<CR>:NvimTreeOpen<CR>]]

vim.cmd [[nmap <F5> gT]]
vim.cmd [[imap <F5> <Esc>gT]]

vim.cmd [[nmap <F6> gt]]
vim.cmd [[imap <F6> <Esc>gt]]

vim.cmd [[nmap <F8> :windo bd<CR>]]
vim.cmd [[imap <F8> <Esc>:windo bd<CR>]]

vim.cmd [[nmap <F12> <C-]>]]
vim.cmd [[imap <F12> <Esc><C-]>]]

vim.cmd [[autocmd VimEnter * NvimTreeOpen]]
vim.cmd [[autocmd VimEnter * wincmd p]]
vim.cmd [[command Q qa]]
vim.cmd [[command Qw wqa]]

vim.lsp.enable("clangd")
