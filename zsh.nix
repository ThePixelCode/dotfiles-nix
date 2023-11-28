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
          (let src = pkgs.fetchFromGitHub{
            owner = "ThePixelCode";
            repo = "oh-my-zsh-powerlevel10k-nix";
            rev = "main";
            sha256 = "sha256-iNdM0gdjlvX2Vsh6MfwAgXZ9LOfYLMI1XiTQnvl8KIE=";
          }; in pkgs.callPackage "${src}/default.nix" {})
        ];
        theme = "powerlevel10k/powerlevel10k";
      };
    };
  };
}
