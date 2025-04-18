{ config, pkgs, ... }: 
{
  services.traefik = {
    staticConfigOptions = {
      certificateResolvers = {
        letsEncrypt = {
          acme = {
            email = "p_konsti@outlook.de";
	    storage = "/var/lib/traefik/acme.json";
	    httpChallenge = {
              entryPoint = "web";
	    };
	  };
	};
      };
    };
  };
}
