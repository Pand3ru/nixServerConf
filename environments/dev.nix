{ config, pkgs, ... }:
{
  services.traefik = {
    staticConfigOptions = {
      tls = {
        certificates = [{
          certFile = "/var/lib/traefik/self-signed.crt";
	  keyFile = "/var/lib/traefik/self-signed.key";
	}];
      };
    };
  };

  system.activationScripts.generateTraefikSelfSigned = ''
    mkdir -p /var/lib/traefik
    if [ ! -f /var/lib/traefik/self-signed.crt ]; then
      ${pkgs.openssl}/bin/openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /var/lib/traefik/self-signed.key \
	-out /var/lib/traefik/self-signed.crt \
	-subj "/CN=localhost"
      chmod 600 /var/lib/traefik/self-signed.key
      chown /var/lib/traefik/self-signed.crt
      chown /var/lib/traefik/self-signed.key
    fi
  '';

  # From guest -> host, right?
  #virtualisation.forwardPorts = [
  #  { from = "host"; host.port = 8080; guest.port = 80; }
  #  { from = "host"; host.port = 8443; guest.port = 443; }
  #];
}
