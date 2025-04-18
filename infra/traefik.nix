{
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      log = {
        level = "DEBUG";
      };

      certificatesResolvers = {
        le = {
          acme = {
            email = "p_konsti@outlook.de";
	    storage = "/var/lib/traefik/acme.json";
	    httpChallenge = {
              entryPoint = "web";
	    };
	  };
	};
      };

      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {
          address = ":443";
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        middlewares = {
  	  redirect-to-https = {
            redirectscheme = {
              scheme = "https";
            };
          };

	  # Force browsers to use https
          hsts = {
            headers = {
              forceSTSHeader = true;
              stsIncludeSubdomains = true;
              stsPreload = true;
              stsSeconds = 15552000;
            };
          };
        };
      };
    };
  };
}

