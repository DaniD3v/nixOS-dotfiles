_: {
  programs.ssh = {
    matchBlocks = {
      "aur.archlinux.org" = {
        identityFile = "~/.secrets/ssh/aur";
        user = "aur";
      };
      "github.com" = {
        identityFile = "~/.secrets/ssh/github";
        user = "git";
      };
    };
  };
}
