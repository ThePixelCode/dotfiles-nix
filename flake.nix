{
  inputs = {
    # flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-23.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: { # flatpaks, nixpkgs, home-manager, ... }: {
    nixosConfigurations."ShiroPC" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # flatpaks.nixosModules.default

        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."shiro" = import ./home.nix;
        }
      ];
    };
  };
}
