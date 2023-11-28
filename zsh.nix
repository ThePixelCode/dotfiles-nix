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
          (pkgs.callPackage ./custom_packages/zsh-nix-shell/default.nix {})
          (pkgs.callPackage ./custom_packages/powerlevel10k/default.nix {})
        ];
        theme = "powerlevel10k/powerlevel10k";
      };
    };
  };
}
