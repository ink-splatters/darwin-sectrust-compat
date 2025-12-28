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
            inherit src;
            modRoot = "./examples/hello-bigsur";
            vendorHash = "sha256-9j+EXca38U0H8WLmmW6BU5lZn/JgO+W+rLxP6p0nVfQ=";

            env.CGO_ENABLED = 1;
          }
          // config.commonArgs;
      };
    };
  };
}
