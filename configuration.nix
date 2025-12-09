{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["puppy"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  networking.hostName = "crate"; 
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 22 80 443 ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      switch = "nh os switch ~/nix --accept-flake-config";
      gc = "git commit";
      ga = "git add";
      ls = "eza";
    };
  };

  users.users.puppy = {
    isNormalUser = true;
    description = "puppy";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
     enable = true;
     withUWSM = true; 
     xwayland.enable = true; 
  };

  programs.nh = {
     enable = true;
     clean.enable = true;
     clean.extraArgs = "--keep-since 4d --keep 3";
     flake = "/home/puppy/nix";
  };

  environment.systemPackages = with pkgs; [
     git
     vim 
     ripgrep
     ghostty
     librewolf
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "puppy";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  system.stateVersion = "25.05";
}
