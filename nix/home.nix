{
  inputs,
  username,
  system,
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

      ./programs/alacritty.nix
      ./programs/neovim.nix
      ./programs/fish.nix
      ./programs/git.nix
      ./programs/ssh.nix

      ./theming/matugen.nix
      ./theming/firefox.nix
      ./theming/gtk.nix

      ./other/onedrive.nix
      ./other/cargo.nix
    ]
    ++ userConfig;

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = _: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    sessionPath = [".local/bin"];
    file.".local/bin" = {
      source = ../scripts;

      executable = true;
      recursive = true;
    };

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
