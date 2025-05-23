# TODO:

## Fixes:

- [ ] make `nix shell` work in prompt
- [ ] librewolf options not applying?
- [ ] fix bordergradient animation in hyprland. [github issue](https://github.com/hyprwm/Hyprland/issues/5693)
- [ ] fix pywalfox extension not working [gitlab issue](https://gitlab.com/rycee/nur-expressions/-/issues/217)
- [ ] fix home.sessionPath [github issue](https://github.com/nix-community/home-manager/issues/3417)
- [ ] fix rclone systemd error [github issue](https://github.com/rclone/rclone/issues/3655)
- [ ] replace broken swaylock & swayidle

## Code-Quality:

- [ ] use lib.optionals instead of manual if-else chain
- [ ] rewrite nix-which script
- [ ] make bitwarden a module with configurable email.
- [ ] remove the email address from the git module/ define it in users/notyou.nix
- [ ] replace "~/.local/bin/wal" with a proper deriviation

## Easy:

- [ ] add librewolf save site data exceptions to home-manager
- [ ] add completition for the nix fish abbreviations
- [ ] somehow save prismlauncher configurations
- [ ] update README to reflect new user-system changes
- [ ] add custom tiling with dwindle layout [docs](https://wiki.hyprland.org/Configuring/Dwindle-Layout/)
- [ ] make it possible to switch from mirroring/2nd display without modifying the config

## Low-Effort:

- [ ] setup just or sth to run commands with hx
- [ ] incorporate activate script into default package -> Allow deployment without downloading
- [ ] proper bitwarden setup with bitwarden-rofi and pinentry
- [ ] biblata cursors
- [ ] try out hyprlock
- [ ] try some hyprland plugins
- [ ] setup backup with rustic-rs
- [ ] git pgp signatures
- [ ] save WLAN connections as secrets
- [ ] remove speech-dispatch from librewolf for 600Mb

## High-Effort

- [ ] write ags widgets
- [ ] picture in picture mode on hyprland (pins) + gnome calculator pin
- [ ] write betterdiscord hm module and configure theme properly instead of using quickCss
- [ ] merge with system-dotfiles to avoid wasting space because of 2 channels
- [ ] make bootstrapping easier for myself with a custom flake for easily installing everything + fetching stuff from bitwarden
- [ ] disko setup so that install is completely automatic
- [ ] custom ISO which installs completely automatically
- [ ] proper matugen hm-module [github PR](https://github.com/InioX/matugen/pull/68)
- [ ] impermanence
- [ ] find/write a proper screenshot tool
- [ ] proper Require = "network-online.target" on onedrive script

## Matugen theming
- [ ] helix
- [ ] Spotify
- [ ] Steam
- [ ] Dynamically reload gtk theme
- [ ] improve gtk theme side-bar

## Completed (for motivational purposes)

- [x] properly setup C#
- [x] include tide in setup
- [x] matugen integration
- [x] improve neovim config
- [x] install rust toolchain from overlay
- [x] automatically import flake modules
- [x] make flake packages accessible with packageOverrides
- [x] optimized flake inputs
- [x] replace imperative rust installation
- [x] update shell aliases to pure nix commands
- [x] remove system variable in flake.nix -> flake-utils
- [x] make dotfiles username independent
- [x] secret management (not world readable & install without secrets)
- [x] fix github secrets disappearing on garbage collect [github issue](https://github.com/NixOS/nix/issues/10924)
- [x] make default.nix files and import all the paths in there.
- [x] fix rofi wallpaper menu not working
- [x] configure 2 monitor setup
- [x] find good linter & fix all errrors [linter list](https://discourse.nixos.org/t/list-of-nix-linters/19279)
- [x] auto-fill username in ./activate script
- [x] pass ./activate script flags to home-manager switch
- [x] fix hyprshot ouptput mode
- [x] Port the neovim config
- [x] fix touchpad script
- [x] fix obs
- [x] setup rofi
- [x] replace hyprpaper with swww
- [x] actually add asus stuff to make conditional
- [x] translate hyprland config to nix native one
- [x] move dconf to theming category
- [x] add username-dependant packages
- [x] move system packages to home.nix
- [x] add a README
- [x] get the flake to work
- [x] add ags to flake
- [x] rclone secrets
- [x] move home packages to modules
- [x] fix obs/screensharing (second time)
- [x] fix steam/hyprland (mesa version mismatch?)
