{
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      log = {
        level = "WARN";
      };

      api = {}; 

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
        routers = {
	  http-catchall = {
            rule = "HostRegexp(`{any:.+}`)";
            entrypoints = [ "web" ];
            middlewares = [ "redirect-to-https" ];
	    service = "noop@internal";
          };
        };
      };
    };
  };
}

