{pkgs, ...}: {
  imports = [../other/rog-strix.nix];

  home.packages = with pkgs; [
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
    jetbrains.datagrip
    unstable.zed-editor

    bitwarden-desktop
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
    cargo-machete
    wl-clipboard
    cargo-sweep
    shellcheck
    ripgrep
    screen
    tokei
    btop
    nmap
    tlrc # rust tldr client
    git
    gcc

    # CLI: applications
    (import ../programs/rust-toolchain.nix pkgs)
    android-tools
    aircrack-ng
    diesel-cli
    macchanger
    rustic-rs
    python3
    docker
    figlet

    # CLI: additional
    fastfetch
    textplots
    spotdl
    bun

    # CLI: nix related
    alejandra
    nix-tree
    deadnix
    statix

    # blurgh for school
    ciscoPacketTracer8
    # teams-for-linux
    dotnet-sdk_8
  ];

  programs = {
    alacritty.enable = true;
    librewolf.enable = true;
    helix.enable = true;
    fish.enable = true;
    git.enable = true;
    ssh.enable = true;

    # requires pipewire.enable = true; in configuration.nix
    obs-studio.enable = true;
  };
}
