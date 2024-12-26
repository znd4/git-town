{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    {
      flake-parts,
      nixpkgs,
      self,
    }@inputs:
    let
      lib = nixpkgs.lib;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        homeManagerModules = {
          default = import ./nix/home-manager.nix;
        };
      };
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          packages = {
            default = pkgs.buildGoModule {
              pname = "git-town";
              version = "v16.7.0";
              src = self;
              vendorHash = null;
            };
          };
        };
    };
}
