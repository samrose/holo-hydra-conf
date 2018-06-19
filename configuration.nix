{ config,lib, pkgs, ... }:
{
  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  ec2.hvm = true;
    services = {
    hydra = {
      enable = true;
      hydraURL = "http://ec2-18-222-119-244.us-east-2.compute.amazonaws.com"; # externally visible URL
      notificationSender = "hydra@holo.host"; # e-mail of hydra service
      # a standalone hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
      buildMachinesFiles = [];
      # you will probably also want, otherwise *everything* will be built from scratch
      useSubstitutes = true;
      listenHost = "0.0.0.0";
      port = 3000;
  };
  
    nginx.enable = true;
    nginx.config = pkgs.lib.readFile /root/nginx.conf;
  };
  networking.firewall.allowedTCPPorts = [80 22];
}
