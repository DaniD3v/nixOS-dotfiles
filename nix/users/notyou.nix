{pkgs, ...}: {
  imports = [../other/rog-strix.nix];

  home.packages = with pkgs; [
    # jetbrains
    unstable.jetbrains.rust-rover
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.webstorm
    jetbrains.datagrip
    android-studio

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
    wl-clipboard
    shellcheck
    diesel-cli
    rustic-rs
    python3
    rustup
    tokei
    btop
    nmap
    git
    gcc

    # CLI: additional
    silver-searcher # this is ag
    cargo-expand
    pulsemixer
    fastfetch
    textplots
    rustcat
    udict
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
    neovim.enable = true;
    fish.enable = true;
    git.enable = true;
    ssh.enable = true;

    # requires pipewire.enable = true; in configuration.nix
    obs-studio.enable = true;
  };
}
