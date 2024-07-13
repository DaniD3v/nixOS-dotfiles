{
  description = "DaniD3v's corn-flakes";

  inputs = {
    # list of possible usernames on this machine
    usernames = {
      url = "file+file:///etc/passwd";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:InioX/Matugen";
      # url = "path:/home/notyou/devel/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    # A list of all possible usernames on this machine
    # Will create a set with fitting home-manager configurations for each of them.
    #
    # This does not impact perforamnce because home-manager chooses
    # which one of them it wants to evaluate.
    usernames = with builtins;
      map (e: elemAt e 0) (
        filter isList (
          split "\n([^:]+)" "\n${readFile inputs.usernames}"
        )
      );

    generateHomeConfig = username:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        modules = [./nix/home.nix];

        extraSpecialArgs = {
          inherit inputs username system;
        };
      };
  in {
    packages.${system}.default = home-manager.defaultPackage.${system};

    homeConfigurations = builtins.listToAttrs (map (
        name: {
          inherit name;
          value = generateHomeConfig name;
        }
      )
      usernames);
  };
}
