{pkgs, ...}: {
  programs.neovim = {
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      nerdtree
      coq-artifacts
      coq_nvim

      vim-airline
      vim-devicons
      gruvbox
      tokyonight-nvim
    ];

    extraConfig = ''
      " share system clipboard
      set clipboard+=unnamedplus

      " skip through line breaks with hjkl and <- ->
      set whichwrap+=<,>,h,l,[,]

      " Scrolling with Ctrl + j/k
      nnoremap <C-k> <C-y>
      nnoremap <C-j> <C-e>

      " Scrolling with Ctrl + Up/Down arrow keys
      nnoremap <C-Up> <C-y>
      nnoremap <C-Down> <C-e>

      " reload command
      command! Reload source $MYVIMRC"

      colorscheme tokyonight

      filetype on
      filetype plugin on

      set number
      set nowrap

      set expandtab
      set tabstop=4
      set shiftwidth=4

      set incsearch
      set wildmenu
      set wildmode=list:longest
      set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
    '';

    extraLuaConfig = ''
      require("nvim-autopairs").setup()
    '';

    extraPackages = with pkgs; [
      # TODO install lsps directly
      cargo # Mason expects cargo
    ];
  };
}
