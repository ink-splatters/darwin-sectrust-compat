# Hello Bigsur

## Building

### Option A.

with `nix`, from the project root:

```sh
nix build .#hello-bigsur
```

### Option B.

with `go 1.25`

#### on modern macOS

```sh
CGO_ENABLED=1 GOFLAGS="-tags=sectrust_compat" go build
```

#### on Big Sur

```sh
LIBSECCOMPAT=../../libsecurity_compat.dylib
# LIBSECCOMPAT=../../result/lib/libsecurity_compat.dylib

SDKROOT="<path>" \
DYLD_INSERT_LIBRARIES="$LIBSECCOMPAT" \
DYLD_FORCE_FLAT_NAMESPACE=1 \
CGO_ENABLED=1 \
GOFLAGS="-tags=sectrust_compat" \
  go build
```

_NOTES_:

- need for `SDKROOT` assumes Xcode is not installed, but you may use Xcode macOS SDK from your main macOS or from nix path
- `sectrust_compat` is not needed if macOS SDK version is below 12, which you could get e.g. from `nixpkgs`

## Running

```sh
❯ HELLO=./hello-bigsur
# ❯ HELLO = ../../result/bin/hello-bigsur

❯ $HELLO
Hello legacy Big Sur world!

```
