{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.walker.homeManagerModules.default
  ];
  home.username = "puppy";
  home.homeDirectory = "/home/puppy";
  home.file."${config.xdg.configHome}" = {
    source = ./dotfiles;
    recursive = true;
  };

  home.packages = with pkgs; [
    zip
    unzip
    ripgrep
    which
    btop
    (discord.override {
      withVencord = true;
    })
  ];

  programs.git = {
    enable = true;
    userName = "puppygrrl";
    userEmail = "puppygirl@tuta.io";
  };

  programs.walker = {
    enable = true;
    runAsService = true;
  };

  programs.neovim = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
