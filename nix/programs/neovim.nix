{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      mason-nvim
      nvim-autopairs
      nerdtree
      coq-artifacts
      coq_nvim

      vim-airline
      vim-devicons
      gruvbox
      tokyonight-nvim
    ];

    extraPackages = with pkgs; [
      # TODO install lsps directly
      cargo # Mason expects cargo
    ];
  };
}
