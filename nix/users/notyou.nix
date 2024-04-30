{pkgs, ...}: {
  imports = [../other/rog-strix.nix];

  home.packages = with pkgs; [
    # jetbrains
    unstable.jetbrains.rust-rover
    unstable.android-studio
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.webstorm
    jetbrains.datagrip

    # OS GUI: essential
    gnome-text-editor
    unstable.errands
    gnome.nautilus
    libreoffice
    apostrophe
    gnome.eog
    warp

    # OS GUI: additional
    gnome.gnome-disk-utility
    gnome.gnome-characters
    gnome.gnome-calculator
    gnome.gnome-clocks
    unstable.dialect
    gnome.totem
    fragments
    diebahn
    baobab

    # Applications
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    teams-for-linux
    prismlauncher
    burpsuite
    geogebra6
    qFlipper
    blender
    spotify
    gimp

    # CLI: essential
    python3
    rustup
    nmap
    git

    # CLI: additional
    wl-clipboard
    pulsemixer
    alejandra
    fastfetch
    rustic-rs
    tokei
    btop
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
