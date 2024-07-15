{
  inputs,
  username,
  system,
  config,
  ...
}: let
  userConfig =
    if builtins.pathExists ./users/${username}.nix
    then [./users/${username}.nix]
    else [];
in {
  imports =
    [
      ./programs
      ./desktop
      ./theming
      ./neovim
      ./other
    ]
    ++ userConfig;

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = prev: (
      {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          inherit (config.nixpkgs) config;
        };
        pure-nixpkgs = prev;
      }
      # add flake-input packages to pkgs
      // builtins.mapAttrs (
        name: value:
          if value ? packages
          then
            (
              # if there's only a default package expose it directly
              let
                packages = value.packages.${system};
              in
                if builtins.all (name: name == "default") (builtins.attrNames packages)
                then packages.default
                else packages
            )
          # then value.packages.${system}
          else prev.${name} or throw "package not found"
      )
      inputs
    );
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
