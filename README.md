# dotfiles-nix
Moved dotfiles to be nixos only

## How to use
0. set hardware partitions and anything that goes on `hardware-configuration.nix`
1. run `git clone https://github.com/ThePixelCode/dotfiles-nix.git` in the same partition of `/etc/nixos/`
2. run `sudo cp /etc/nixos/hardware-configuration.nix /path/to/cloned/repo`
3. run `sudo rm -rf /etc/nixos && sudo ln -sn /path/to/cloned/repo /etc/nixos`
4. set `/path/to/cloned/repo/secrets.nix` with:
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
5. run `sudo nixos-rebuild switch --impure --flake /path/to/cloned/repo#ShiroPC`
Make sure you add `--impure` flag on the args
