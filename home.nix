{ config, pkgs, ... }:

{
  home.username = "puppy";
  home.homeDirectory = "/home/puppy";

  home.packages = with pkgs; [
    zip
    unzip
    ripgrep
    which
    btop
  ];

  programs.git = {
    enable = true;
    userName = "puppygrrl";
    userEmail = "puppygirl@tuta.io";
  };

  home.stateVersion = "25.05";
}
