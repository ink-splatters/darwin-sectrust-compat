{lib, ...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    options = {
      commonArgs = lib.mkOption {
        type = lib.types.attrs;
        default = {
          buildInputs = with pkgs; [
            apple-sdk_11
            (darwinMinVersionHook "10.14")
          ];
          nativeBuildInputs = with config.toolchain.llvm;
            [
              bintools
              clang
            ]
            ++ [config.toolchain.go_1_25];
        };
      };
    };
  };
}
