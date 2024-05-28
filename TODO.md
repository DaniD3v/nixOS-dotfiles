# TODO:

## Fixes:

- [ ] fix bordergradient animation in hyprland. [github issue](https://github.com/hyprwm/Hyprland/issues/5693)
- [ ] fix pywalfox extension not working [gitlab issue](https://gitlab.com/rycee/nur-expressions/-/issues/217)
- [ ] fix home.sessionPath [github issue](https://github.com/nix-community/home-manager/issues/3417)

## Code-Quality:

- [ ] remove system variable in flake.nix -> flake-utils
- [ ] make flake packages accessible with packageOverrides
- [ ] rewrite nix-which script
- [ ] make default.nix files and import all the paths in there.
- [ ] make bitwarden a module with configurable email.
- [ ] remove the email address from the git module/ define it in users/notyou.nix

## Easy:

- [ ] update README to reflect new user-system changes

## Low-Effort:

- [ ] proper bitwarden setup with bitwarden-rofi and pinentry
- [ ] biblata cursors
- [ ] try out hyprlock
- [ ] try some hyprland plugins
- [ ] setup backup with rustic-rs
- [ ] git pgp signatures
- [ ] save WLAN connections as secrets

## High-Effort

- [ ] proper matugen hm-module [github PR](https://github.com/InioX/matugen/pull/68)
- [ ] matugen integration
- [ ] improve neovim config
- [ ] impermanence
- [ ] secret management (not world readable & install without secrets)
- [ ] find/write a proper screenshot tool
- [ ] write ags widgets
- [ ] proper Require = "network-online.target" on onedrive script

## Completed (for motivational purposes)

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

