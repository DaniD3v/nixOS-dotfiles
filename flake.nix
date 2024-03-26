{
  description = "DaniD3v's corn-flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
    home-manager,
    ags,
  } @ inputs: let
    system = "x86_64-linux";
  in {
    packages.${system}.default = home-manager.defaultPackage.${system};

    homeConfigurations.notyou = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {inherit system;};
      extraSpecialArgs = {inherit inputs;};

      modules = [./modules/home.nix];
    };
  };
}
