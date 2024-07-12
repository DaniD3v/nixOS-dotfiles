_: {
  programs.neovim = {
    extraConfig = ''
      " rebind leader to space
      map <Space> <Leader>

      " reload
      nnoremap <leader>rel :source $MYVIMRC<CR>

      " use system clipboard
      nnoremap <leader>s "*
    '';
  };
}
