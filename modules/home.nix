{
  username,
  pkgs,
  ...
}: {
  imports = [
    ./desktop/hyprland.nix

    ./programs/neovim.nix
    ./programs/kitty.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/ssh.nix

    ./other/onedrive.nix
    # ./nix/other/wallust/wallust.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionPath = [".local/bin"];
    file.".local/bin" = {
      source = ../scripts;

      executable = true;
      recursive = true;
    };

    packages = with pkgs; [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })

      rofi-wayland # yerp
      dunst

      btop
    ];

    stateVersion = "23.11";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.home-manager = {
    enable = true;
    # path = "$HOME/devel/home-manager";
  };
}
