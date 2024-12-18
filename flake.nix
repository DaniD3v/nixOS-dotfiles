{
  description = "DaniD3v's corn-flakes";

  inputs = {
    # list of possible usernames on this machine
    etc-passwd = {
      url = "file+file:///etc/passwd";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    matugen = {
      # url = "github:InioX/Matugen"; # upstream
      url = "github:DaniD3v/Matugen/fix-compilation-for-unix"; # fix while upstream is broken

      # url = "path:/home/notyou/devel/matugen"; # local developement branch

      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    hestia-bar = {
      url = "/home/notyou/programming/hestia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.inputs.systems.follows = "systems";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
    systems = {};
  };

  outputs = {
    flake-utils,
    etc-passwd,
    nixpkgs,
    home-manager,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        # A list of all possible usernames on this machine
        # Will create a set with fitting home-manager configurations for each of them.
        #
        # This does not impact perforamnce because home-manager chooses
        # which one of them it wants to evaluate.
        usernames = with builtins;
          map (e: elemAt e 0) (
            filter isList (
              split "\n([^:]+)" "\n${readFile etc-passwd}"
            )
          );
      in {
        packages = {
          default = home-manager.defaultPackage.${system};

          # defined in packages to be generic over system
          homeConfigurations = builtins.listToAttrs (map
            (
              username: {
                name = username;
                value = home-manager.lib.homeManagerConfiguration {
                  pkgs = import nixpkgs {inherit system;};
                  modules = [
                    inputs.matugen.nixosModules.default
                    ./nix/home.nix
                  ];

                  extraSpecialArgs = {
                    inherit inputs username system;
                  };
                };
              }
            )
            usernames);
        };
      }
    );
}
