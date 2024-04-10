{pkgs, ...}: {
  programs.fish = {
    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        src = z.src;
      } # fuzzy cd
      {
        name = "tide";
        src = tide.src;
      } # prompt
      {
        name = "done";
        src = done.src;
      } # notification after long commands
      {
        name = "sponge";
        src = sponge.src;
      } # removes failed commands from history
      {
        name = "puffer";
        src = puffer.src;
      } # '...' -> '../..' and '!!' -> <previous command>
      {
        name = "autopair";
        src = autopair.src;
      }
    ];

    shellAbbrs = {
      nmwifi = "nmcli device wifi";
      with-pkg = "nix-shell --run fish -p";

      bcomp = "tar --use-compress-program='pigz -9' -cf compressed.tar.xz";
      yoink = "git clone --depth 1 --recurse-submodules";

      nmcn = "nmcli device wifi connect";
      btcn = "bluetoothctl connect";
    };

    shellAliases = {
      yt-dlp-mp4 = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
      yt-dlp-mp3 = "yt-dlp -x --audio-format mp3 --audio-quality 0";
      zclippy = "cargo clippy -- -W clippy::complexity -W clippy::correctness -W clippy::perf -W clippy::style -W clippy::suspicious";

      nano = "nvim";
      cat = "bat";
    };

    interactiveShellInit = ''
      set fish_greeting
      bind \b backward-kill-word
      fish_add_path ~/.local/bin
    '';
  };

  # Required for the aliases to work
  home.packages = with pkgs; [
    yt-dlp
    pigz
    bat
  ];
}
