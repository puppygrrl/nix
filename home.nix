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
  home.enableNixpkgsReleaseCheck = false;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  home.packages = with pkgs; [
    neofetch
    readest
    gcc
    go
    wget
    nixfmt-rfc-style
    eza
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

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 15;
  };
  gtk = {
      enable = true;
      font.name = "TeX Gyre Adventor 10";
      theme = {
        name = "Juno";
        package = pkgs.juno-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
      };

      gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    
  };
  home.stateVersion = "25.05";
}
