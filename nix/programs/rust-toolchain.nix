pkgs:
pkgs.fenix.complete.withComponents [
  "rust-std"
  "cargo"
  "rustc"

  "rust-analyzer"
  "rustfmt"
  "clippy"
  "miri"

  "rust-src"
  "rustc-dev"
  "llvm-tools-preview"
]
