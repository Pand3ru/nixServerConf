{
  virtualisation.oci-containers.containers."slash" = {
    image = "docker.io/yourselfhosted/slash:latest";
    ports = ["127.0.0.1:3010:5231"];
    volumes = [
      "slash_data:/var/opt/slash"
    ];
  };
  # Traefik configuration specific to littlelink
  services.traefik.dynamicConfigOptions.http = {
    routers.slash = {
      rule = "Host(`pankratov.de`)";
      tls = {
        certResolver = "letsEncrypt";
      };
      service = "slash";
      entrypoints = "websecure";
    };
  };
}

