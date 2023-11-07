{
  description = "A flake for building Hello World";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs.legacyPacakges.${system}.nixpkgs-fmt;
      defaultPackage.${system} =
        with import nixpkgs
          {
            inherit system;
          };
        stdenv.mkDerivation {
          name = "hello";
          src = self;
          buildPhase = ''gcc -o hello ./hello.c'';
          installPhase = ''mkdir -p $out/bin; install -t $out/bin hello '';
        };
    };
}
