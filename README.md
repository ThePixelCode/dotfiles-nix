# dotfiles-nix
Moved dotfiles to be nixos only

## How to use
0. set hardware partitions and anything that goes on `hardware-configuration.nix`
1. set `/etc/nixos/secrets.nix` with:
```nix
{config, pkgs, ...}:
{
	config = {
		users.users.shiro.description = "UserName";
		programs.git = {
			userEmail = "user@email.com";
    	    userName = "username";
		};
	};
}
```
2. clone this repo `git clone https://github.com/ThePixelCode/dotfiles-nix.git`
3. run `sudo nixos-rebuild switch --impure --flake /path/to/cloned/repo?submodules=1#ShiroPC`
Make sure you add `--impure` flag on the args
