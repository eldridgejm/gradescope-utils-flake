{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/20.09;

  outputs = { self, nixpkgs }: 
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
      {
        defaultPackage = forAllSystems (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in

            pkgs.python3Packages.buildPythonPackage rec {
                pname = "gradescope-utils";
                version = "0.4.0";
                name = "${pname}-${version}";
                src = builtins.fetchurl {
                  url = "https://files.pythonhosted.org/packages/bf/71/d107b262e6a002f66369e42f22044f21d744353e76fd69ae3c0e47410b40/gradescope-utils-0.4.0.tar.gz";
                  sha256 = "1733hb87gkr7cs9wdn8paql1jw37z3jszhr55x7yhjasvx7r293g";
                };
                propagatedBuildInputs = [ pkgs.python3Packages.notebook ];
              }

        );
      };
}
