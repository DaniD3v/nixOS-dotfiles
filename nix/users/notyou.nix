{pkgs, ...}: {
  imports = [../other/rog-strix.nix];

  home.packages = with pkgs; [
    # jetbrains
    jetbrains.rust-rover

    # OS GUI: essential
    gnome.gnome-disk-utility
    gnome.gnome-calculator
    gnome-text-editor
    gnome.nautilus
    libreoffice
    pwvucontrol
    gnome.eog
    marktext
    errands
    warp

    # OS GUI: additional
    gnome.gnome-characters
    gnome.gnome-clocks
    video-trimmer
    gnome.totem
    textpieces
    fragments # torrent client
    diebahn
    dialect
    baobab

    # Applications
    # ciscoPacketTracer8
    # teams-for-linux
    prismlauncher
    burpsuite
    geogebra6
    qFlipper
    blender
    spotify
    postman
    vesktop
    gimp

    # CLI: essential
    (fenix.complete.withComponents [
      "rust-std"
      "cargo"
      "rustc"

      "rustfmt"
      "clippy"
      "miri"

      "rust-src"
      "rustc-dev"
      "llvm-tools-preview"
    ])
    cargo-machete
    wl-clipboard
    shellcheck
    ripgrep
    tokei
    btop
    nmap
    tlrc # rust tldr client
    git
    gcc

    # CLI: applications
    android-tools
    aircrack-ng
    diesel-cli
    macchanger
    rustic-rs
    python3
    figlet

    # CLI: additional
    fastfetch
    textplots

    # CLI: nix related
    alejandra
    nix-tree
    deadnix
    statix
  ];

  programs = {
    alacritty.enable = true;
    firefox.enable = true;
    helix.enable = true;
    fish.enable = true;
    git.enable = true;
    ssh.enable = true;

    # requires pipewire.enable = true; in configuration.nix
    obs-studio.enable = true;
  };
}
