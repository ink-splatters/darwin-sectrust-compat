{
  imports = [
    ./common
  ];
  perSystem = {config, ...}: let
    inherit (config) commonArgs src toolchain;
    name = "security_compat";
  in {
    config = {
      packages = {
        security_compat = toolchain.llvm.stdenv.mkDerivation ({
            inherit name;
            inherit src;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/lib
              cp lib${name}.dylib $out/lib

              runHook postBuild
            '';
          }
          // config.commonArgs);

        hello-bigsur =
          toolchain.buildGo125Module {
            name = "hello-bigsur";
            src = "${src}/examples/hello-bigsur";
            vendorHash = "sha256-rBMT8t76B9TnwvhzBSUG9KBEbyx1zn7J2Yc2C48SZ48=";

            env.CGO_ENABLED = 1;
          }
          // config.commonArgs;
      };
    };
  };
}
