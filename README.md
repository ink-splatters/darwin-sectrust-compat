# security-compat

A shim that does exactly one thing:

provides symbol `_SecTrustCopyCertificateChain` (macOS 12+ API) on earlier macOS versions.

## Motivation

Make `go 1.25` toolchain and binaries, produced by it, run on macOS Big Sur.

## Building

### With make (Xcode required)

```sh
make
```

### With nix

```sh
nix build
```

### Verify

The dylib must export `_SecTrustCopyCertificateChain` (and must not import it).

<details><summary>Click here for details</summary>

```sh
LIBSECCOMPAT=libsecurity_compat.dylib
# LIBSECCOMPAT=result/lib/libsecurity_compat.dylib

❯ nm -u "$LIBSECCOMPAT" | grep -o _SecTrustCopyCertificateChain

❯ nm -g "$LIBSECCOMPAT" | grep -o _SecTrustCopyCertificateChain
_SecTrustCopyCertificateChain

```

</details>

## Usage Examples

### Running go1.25 on macOS Big Sur

```sh
❯  DYLD_INSERT_LIBRARIES="$LIBSECCOMPAT" DYLD_FORCE_FLAT_NAMESPACE=1 go version
go version go1.25.4 darwin/arm64

```

## Shim availability

As a safenet, the shim is disabled if newer macOS SDK is detected. 

To override this behavior, use `-DSECTRUST_COMPAT`.

Details: [security_compat.c](./security_compat.c)

## License

[MIT](./LICENSE)
