{ llvmPackages_17, lib, lld_17, pkgs, system, ... }:
let inherit (llvmPackages_17) bintools libcxx;
in rec {
  CFLAGS =
    lib.optionalString ("${system}" == "aarch64-darwin") "-mcpu=apple-m1 ";
  CXXFLAGS = "${CFLAGS}";
  LDFLAGS = "-fuse-ld=lld -lc++ -lc++abi";

  buildInputs = [ libcxx bintools ];
  nativeBuildInputs = with pkgs; [
    ccache
    cmake
    gnumake
    lld_17
    ninja
    pkg-config
  ];
}


{ pkgs, common, self, system, ... }:
{

  default = mkShell.override { stdenv = swiftPackages.stdenv; } {

    inherit (common) CFLAGS CXXFLAGS LDFLAGS buildInputs nativeBuildInputs;

    name = "swift-shell";

    shellHook = self.checks.${system}.pre-commit-check.shellHook + ''
      export PS1="\n\[\033[01;36m\]‹swift› \\$ \[\033[00m\]"
      echo -e "\nto install pre-commit hooks:\n\x1b[1;37mnix develop .#install-hooks\x1b[00m"
    '';
  };


}
