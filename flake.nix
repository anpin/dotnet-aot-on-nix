{
  description = "basic dotnet aot";
  
  outputs = inputs@{ self, nixpkgs, ... }:
    let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system ; };
    inherit (inputs.nixpkgs) lib; 
    in {
      packages.${system} = 
      { 
        noFix = pkgs.callPackage ./default.nix { linkNugets = false; } ; 
        default = pkgs.callPackage ./default.nix {} ; 
      };
      devShells.${system}.default = import ./shell.nix {inherit pkgs;};

  };
}
