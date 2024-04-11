{
  system,
  username,
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  userConfig =
    if builtins.pathExists ./users/${username}.nix
    then [./users/${username}.nix]
    else [];
in {
  imports =
    [
      ./desktop/hyprland.nix

      ./programs/neovim.nix
      ./programs/kitty.nix
      ./programs/fish.nix
      ./programs/git.nix
      ./programs/ssh.nix

      ./theming/matugen.nix
      ./theming/firefox.nix
      ./theming/gtk.nix

      ./other/onedrive.nix
    ]
    ++ userConfig;

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };

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

      rofi-wayland
      dunst
    ];

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
