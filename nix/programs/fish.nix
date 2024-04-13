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
      nmwifi = "${pkgs.networkmanager}/bin/nmcli device wifi";
      with-pkg = "${pkgs.nix}/bin/nix-shell --run fish -p";

      bcomp = "${pkgs.gnutar}/bin/tar --use-compress-program='${pkgs.pigz}/bin/pigz -9' -cf compressed.tar.xz";
      yoink = "${pkgs.git}/bin/git clone --depth 1 --recurse-submodules";

      nmcn = "${pkgs.networkmanager}/bin/nmcli device wifi connect";
      btcn = "${pkgs.bluez}/bin/bluetoothctl connect";
    };

    shellAliases = {
      yt-dlp-mp4 = "${pkgs.yt-dlp}/bin/yt-dlp f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
      yt-dlp-mp3 = "${pkgs.yt-dlp}/bin/yt-dlp -x --audio-format mp3 --audio-quality 0";
      zclippy = "${pkgs.rustup}/bin/cargo clippy -- -W clippy::complexity -W clippy::correctness -W clippy::perf -W clippy::style -W clippy::suspicious";

      nano = "${pkgs.neovim}/bin/nvim";
      cat = "${pkgs.bat}/bin/bat";
    };

    interactiveShellInit = ''
      set fish_greeting
      bind \b backward-kill-word
      fish_add_path ~/.local/bin
    '';
  };
}
