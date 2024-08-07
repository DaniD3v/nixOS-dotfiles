{pkgs, ...}: {
  imports = [../other/rog-strix.nix];

  home.packages = with pkgs; [
    # jetbrains
    jetbrains.rust-rover

    # OS GUI: essential
    gnome-text-editor
    gnome.nautilus
    libreoffice
    pwvucontrol
    gnome.eog
    marktext
    errands
    warp

    # OS GUI: additional
    gnome.gnome-disk-utility
    gnome.gnome-characters
    gnome.gnome-calculator
    gnome.gnome-clocks
    video-trimmer
    gnome.totem
    textpieces
    fragments
    diebahn
    dialect
    baobab

    # Applications
    ciscoPacketTracer8
    teams-for-linux
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
    wl-clipboard
    shellcheck
    diesel-cli
    rustic-rs
    ripgrep
    python3
    tokei
    btop
    nmap
    git
    gcc

    # CLI: additional
    silver-searcher # this is ag
    cargo-expand
    fastfetch
    textplots
    figlet
    tlrc

    # nix related
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
