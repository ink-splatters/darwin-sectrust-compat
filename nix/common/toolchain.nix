{
  inputs,
  lib,
  ...
}: {
  perSystem = {
    pkgs,
    pkgs-unstable,
    system,
    ...
  }: let
    llvm = pkgs.llvmPackages_latest;
  in {
    config = {
      _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
      };
    };
    options = {
      toolchain = lib.mkOption {
        type = lib.types.attrs;
        default = {
          inherit llvm;
          buildGo125Module = pkgs-unstable.buildGo125Module.override {
            inherit (llvm) stdenv;
          };
          inherit (pkgs-unstable) go_1_25;
        };
      };
    };
  };
}
