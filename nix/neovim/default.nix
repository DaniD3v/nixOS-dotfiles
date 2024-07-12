{pkgs, ...}: {
  imports = [
    ./remap.nix
    ./lsp.nix
  ];

  programs.neovim = {
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      coq-artifacts

      nerdtree

      vim-airline
      vim-devicons
      gruvbox
      tokyonight-nvim
    ];

    extraConfig = ''
      " skip through line breaks with hl and <- ->
      set whichwrap+=<,>,h,l

      " Scrolling with Ctrl + j/k
      nnoremap <C-k> <C-y>
      nnoremap <C-j> <C-e>

      " Scrolling with Ctrl + Up/Down arrow keys
      nnoremap <C-Up> <C-y>
      nnoremap <C-Down> <C-e>

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
  };
}
