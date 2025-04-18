{
  description = "Server configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          ./configuration.nix
	  ./environments/dev.nix
	];
      };

      prod = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          ./configuration.nix
	  ./environments/prod.nix
	];
      };
    };
  };
}
