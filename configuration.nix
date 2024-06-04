# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
 #hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
 hardware.pulseaudio.extraConfig = "load-module module-switch-on-connect";
 environment.systemPackages = with pkgs; [ kitty firefox nano neofetch cpu-x git zsh eza tree emacs neovim tree pciutils pavucontrol ];
 services.xserver.displayManager.autoLogin.enable = true;
 services.xserver.displayManager.autoLogin.user = "f";
 i18n.inputMethod = {
  enabled = "fcitx5";
  fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-rime
      rime-data
  ];
};
 services.v2raya.enable = true;
   systemd.services.keyd = {
    description = "key remapping daemon";
    enable = true;
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.keyd}/bin/keyd";
    };
    wantedBy = [ "sysinit.target" ];
    requires = [ "local-fs.target" ];
    after = [ "local-fs.target" ];
  };

 nix.settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
 boot.kernel.sysctl."kernel.sysrq" = 1;
 time.timeZone = "Asia/Shanghai";

 i18n.defaultLocale = "en_US.UTF-8";
 i18n.extraLocaleSettings = {
   LC_ADDRESS = "zh_CN.UTF-8";
   LC_IDENTIFICATION = "zh_CN.UTF-8";
   LC_MEASUREMENT = "zh_CN.UTF-8";
   LC_MONETARY = "zh_CN.UTF-8";
   LC_NAME = "zh_CN.UTF-8";
   LC_NUMERIC = "zh_CN.UTF-8";
   LC_PAPER = "zh_CN.UTF-8";
   LC_TELEPHONE = "zh_CN.UTF-8";
   LC_TIME = "zh_CN.UTF-8";
 };
 imports =
   [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
   ];

 boot.loader.timeout = 1;
 boot.loader = {
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/efi"; # ← use the same mount point here.
  };
  grub = {
     efiSupport = true;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
  };
};

 networking.hostName = "Nix"; # Define your hostname.
 # Pick only one of the below networking options.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
 networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
 sound.enable = true;
 hardware.pulseaudio.enable = true;
 networking.usePredictableInterfaceNames = false;
 hardware.bluetooth.enable = true; # enables support for Bluetooth
 hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

 # Configure network proxy if necessary
 # networking.proxy.default = "http://user:password@proxy:port/";
 # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 # Select internationalisation properties.
 # console = {
 #   font = "Lat2-Terminus16";
 #   keyMap = "us";
 #   useXkbConfig = true; # use xkb.options in tty.
 # };

 # Enable the X11 windowing system.
 services.xserver.enable = true;


 # Enable the Plasma 5 Desktop Environment.
 services.xserver.displayManager.sddm.enable = true;
 services.xserver.desktopManager.plasma5.enable = true;
  

 # Configure keymap in X11
 # services.xserver.xkb.layout = "us";
 # services.xserver.xkb.options = "eurosign:e,caps:escape";

 # Enable CUPS to print documents.
 # services.printing.enable = true;

 # Enable sound.

 # Enable touchpad support (enabled default in most desktopManager).
 # services.xserver.libinput.enable = true;

 # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.f = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
 };
   # Enable automatic login for the user.
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
system.stateVersion = "23.11"; # Did you read the comment?

}
