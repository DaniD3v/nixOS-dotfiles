{
  description = "DaniD3v's corn-flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:/InioX/Matugen";
      # url = "path:/home/notyou/devel/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    firefox-addons,
    matugen,
    ags,
  } @ inputs: let
    system = "x86_64-linux";
    username = import ./username.nix;
  in {
    packages.${system}.default = home-manager.defaultPackage.${system};

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {inherit system;};
      modules = [./nix/home.nix];

      extraSpecialArgs = {
        inherit inputs username system;
      };
    };
  };
}
