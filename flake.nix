{
  inputs = {
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { flatpaks, nixpkgs, ... }: {
    nixosConfigurations."ShiroPC" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        flatpaks.nixosModules.default

        ./configuration.nix
      ];
    };
  };
}
