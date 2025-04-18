{ config, pkgs, ... }:

{
  imports = [
    ./infra
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Berlin";

  users.mutableUsers = false;

  users.users.panderu = {
    isNormalUser = true;
    group = "panderu";
    extraGroups = [ "wheel" ];
    hashedPassword = "$y$j9T$ngIBPzh2cpa/lr6SsZbeL.$a7GQhL7sto/lf54.MTjvhs2NFbI6ksBxRxCl3yPhK69";
  };

  users.users."panderu".openssh.authorizedKeys.keys = [
  "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBPfW+XOeE2uRMcya7v67oisrcfI37/86ttBHNzmhPXJAAAABHNzaDo= Panderu"
  ];

  users.groups.panderu = {};

  networking = rec {
    networkmanager.enable = true;

    hostName = "homelab";
    domain = "panderu.org";

    firewall = {
      enable = true;
      allowPing = true;
      allowedUDPPorts = [ 51820 ];
      allowedTCPPorts = [ 80 443 22 48654 ];
    };

    useDHCP = true;
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    tree
    iwd
  ];

  system.stateVersion = "24.11";
}
