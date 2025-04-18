{
  virtualisation.oci-containers.containers."slash" = {
    image = "docker.io/yourselfhosted/slash:latest";
    ports = ["127.0.0.1:3010:5231"];
    volumes = [
      "slash_data:/var/opt/slash"
    ];
  };

  services.traefik.dynamicConfigOptions.http = {
    services.slash.loadBalancer.servers = [
      {
        url = "http://localhost:3010/";
      }
    ];

    routers.slash = {
      rule = "Host(`pankratov.de`)";
      tls = {
        certResolver = "le";
      };
      service = "slash";
      entrypoints = [ "websecure" ];
    };
  };
}

