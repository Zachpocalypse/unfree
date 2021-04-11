{
  description = "Flake utils demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          nixpkgs.config = { allowUnfree = true; };
          nix = {
            distributedBuilds = true;
            buildMachines = [
              {
                hostName = "eu.nixbuild.net";
                system = "x86_64-linux";
                maxJobs = 100;
                supportedFeatures = [ "benchmark" "big-parallel" ];
              }
            ];
          };
        };
      in
        {
          defaultPackage = nixpkgs.mkl;
        }
    );
}
