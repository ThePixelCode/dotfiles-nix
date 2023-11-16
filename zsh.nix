{ config, pkgs, ... }:

{
  config = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "gitignore"
          "sudo"
          "zsh-syntax-highlighting"
          "zsh-autosuggestions"
          "nix-zsh-completions"
          "nix-shell"
        ];
        theme = "powerlevel10k/powerlevel10k";
      };
    };
  };
}