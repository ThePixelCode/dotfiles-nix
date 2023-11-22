{ config, pkgs, ... }:

{
  options = {
    programs.zsh = {
      autocd = true;
      enableFzfHistory = true;
    };
  };
  config = {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "gitignore"
          "sudo"
        ];
        customPkgs = [
          pkgs.nix-zsh-completions
          pkgs.zsh-nix-shell
        ];
        theme = "powerlevel10k/powerlevel10k";
      };
    };
  };
}
