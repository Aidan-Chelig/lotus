{ pkgs ? import <nixpkgs> { } }:

with pkgs;
let
  fenix = import (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz") { };
in
mkShell
rec {
  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    udev
    alsa-lib
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr # To use the x11 feature
    libxkbcommon
    wayland # To use the wayland feature
    mold
    cargo-watch
      (
        with fenix;
        combine (
          with default; [
            cargo
            clippy-preview
            latest.rust-src
            rust-analyzer
            rust-std
            rustc
            rustfmt-preview
          ]
        )
      )

  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}