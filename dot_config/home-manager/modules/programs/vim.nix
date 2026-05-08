{
  programs.vim = {
    enable = true;
    extraConfig = ''
      set nocompatible
      set number
      set relativenumber
      set tabstop=4
      set shiftwidth=2
      set expandtab
      set smartindent
      set wrap
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set hidden
      set scrolloff=8
      set noswapfile
      set nobackup
      set undodir=~/.vim/undodir
      set undofile
      set signcolumn=yes
      set termguicolors
      syntax on
      filetype plugin indent on
    '';
  };
}
