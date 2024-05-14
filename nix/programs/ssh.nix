_: {
  programs.ssh = {
    matchBlocks = {
      "aur.archlinux.org" = {
        identityFile = toString ../../secrets/ssh/aur;
        user = "aur";
      };
      "github.com" = {
        identityFile = toString ../../secrets/ssh/github;
        user = "git";
      };
    };
  };
}
