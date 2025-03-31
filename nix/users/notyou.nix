{pkgs, ...}: {
  imports = [../other/rog-strix.nix];

  home.packages = with pkgs; [
    # OS GUI: essential
    gnome-disk-utility
    gnome-text-editor
    gnome-calculator
    libreoffice
    pwvucontrol
    nautilus
    marktext
    errands
    warp
    eog

    # OS GUI: additional
    gnome-characters
    gnome-clocks
    video-trimmer
    textpieces
    fragments # torrent client
    dialect
    baobab
    totem # video player

    # Applications
    jetbrains.datagrip
    jetbrains.webstorm

    unstable.zed-editor
    thunderbird
    bitwarden-desktop
    prismlauncher
    burpsuite
    geogebra6
    obsidian
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
    nodejs-slim
    aircrack-ng
    diesel-cli
    macchanger
    rustic-rs
    python3
    docker
    bun

    # CLI: additional
    fastfetch
    spotdl
    figlet

    # CLI: nix related
    nixos-anywhere
    alejandra
    nix-tree
    deadnix
    statix

    # blurgh for school
    ciscoPacketTracer8
    nodePackages."@angular/cli"
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
