<h1 align="center">
   <img src="./github-assets/logo.svg" width="160"/> 
   <br>
      DaniD3v's CornFlakes
   <br>
</h1>

<!-- add gallery once my dotfiles look good enough -->

> **Note:**  
> **You do not need nixOS to run these dotfiles.**  
> **The nix package manager works on any distro.**  

## Description
My personal nixOS dotfiles.  
This repo only contains user dotfiles. See [system-dotfiles][system-dotfiles] for my system configuration.

> Warning:  
> I haven't actually updated my system-dotfiles so the link
> above is a placeholder to my old gentoo system dotfiles. 
> Feel free to check them out anyways. 

## Overview
### Components
| Base | |
| - | :-
| Window Manager | [Hyprland] |  
| Widgets | [AGS] |
| Application Launcher | [rofi (wayland fork)] |
| Notifications | [dunst] -> [AGS] |
| Lock Screen | [swaylock-effects] |

| Terminal | |
| - | :-
| Shell | [fish] |
| Prompt | [tide] |
| Text Editor | [neovim] |
| Resource Monitor | [btop] |

> Lore:  
> x -> y: Planning to migrate from x to y

<!-- TODO: add Shell aliases + scripts here -->

<!-- TODO: add Keybinds here -->

## Installation
> Note:  
> These dotfiles are mostly for reference purposes.  
> I'd not use these dotfiles yet, because of their lack in modularity.

Before you try any of the following commands, make sure that you have the nix package manager installed.  
The installation instructions can be found [here](https://nixos.org/download/#nix-install-linux).

<!--

This doesn't really work because you need to set the user.
Might be possible to re-add this feature once I make an install script.

### Quick install
> Warning: This command currently won't work because of how I've
> setup my secrets management. Use the command below and add 
> empty secret files for now.

```sh
nix run github:DaniD3v/nixOS-dotfiles --experimental-features 'nix-command flakes' -- switch --flake github:DaniD3v/nixOS-dotfiles
```

-->


### Cloning the repository
If you want to permanently install my dotfiles, I'd recommend to clone this repo.

```sh
git clone https://github.com/DaniD3v/nixOS-dotfiles --depth 1
cd nixOS-dotfiles
```

To get this running as quickly as possible create all of the secret files

```sh
mkdir -p ./secrets/ssh
touch ./secrets/rclone.conf
touch ./secrets/ssh/github
touch ./secrets/ssh/aur
```

You also need to set your own username. Use an editor of your choice to modify `flake.nix`

```nix
...

  nixpkgs,
  home-manager,
  ags,
}: let
  system = "x86_64-linux";
  username = "<insert username here>";
in {
  packages.${system}.default = home-manager.defaultPackage.${system};

...
```

Now you probably want to edit some of those configuration files. Have a look at [Editing](#editing) for more information.

Finally run ```./activate``` in the nixOS-dotfiles folder.

> Note:  
> Don't try running `nix run . -- switch --flake .` manually.
> The way my secrets are handled right now that
> command will always fail.  If you really don't want to 
> use `./activate` for some reason you can use
> `nix run . --switch --flake path:.` as a workaround.


### Uninstalling
To remove my dotfiles from your system simply run

```sh
home-manager uninstall
```

If there's a specific reason you uninstalled my dotfiles, make sure to tell me in a GitHub issue.

## Editing
> Note:  
> These dotfiles might be hard to configure because of their
> lack of modularity.  
> This section is still very much work-in-progress.

### Structure

.  
├── flake.nix  
├── modules | nix modules for configuration  
│   ├── desktop  
│   ├── other  
│   ├── programs  
│   └── theming  
├── external | configuration files that are not written in nix  
│   ├── ags  
│   └── hypr    
└── secrets  

## Credits
[Frost-Phoenix's Flakes](https://github.com/Frost-Phoenix/nixos-config)

> Inspired README
> 
> Made me come up with the name DaniD3v's CornFlakes -  
> I initially assumed (because his name is **Frost**-Phoenix)
> that he wrote Forst-Phoenix's Snowflakes so I wanted to parody
> that. Well turns out he didn't write that and I just made it up
> without realizing.

---

[AGS]

> Best widget tool ever made. You can basically write an entire
> DE with this.

---

[Matugen]

> Material color generation tool.

---

[Aylurs dotfiles](https://github.com/Aylur/dotfiles)

> Made me find out about [Matugen](https://github.com/InioXmatugen) early, which prevented a lot of time being wasted on template-writing.

---


<!-- Links -->

<!-- Personal -->
[system-dotfiles]: https://github.com/DaniD3v/system-dotfiles

<!-- Programs -->
[hyprland]: https://hyprland.org/
[ags]: https://github.com/Aylur/ags
[rofi (wayland fork)]: https://github.com/lbonn/rofi
[dunst]: https://github.com/dunst-project/dunst
[swaylock-effects]: https://github.com/mortie/swaylock-effects
[fish]: https://fishshell.com/
[tide]: https://github.com/IlanCosman/tide
[neovim]: https://github.com/neovim/neovim
[btop]: https://github.com/aristocratos/btop
[matugen]: https://github.com/InioX/matugen