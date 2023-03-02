{ config, pkgs, lib, ... }:
let

  remotePort = 30001;
  hds0-address = __head (lib.splitString "/" (__head config.networking.wireguard.interfaces.hds0.ips));
  httpPort = 3001;
  rootUrl = "http://${hds0-address}:${toString remotePort}"; # CAUTION: no tailing / required

in
{

  age.secrets.gitea-dbpass = {
    file = ../../secrets/gitea-dbpass.age;
    owner = "gitea";
  };

  services.gitea = {
    enable = true;
    appName = "JJDosaGit"; # Give the site a name
    database = {
      type = "postgres";
      passwordFile = config.age.secrets.gitea-dbpass.path;
    };
    domain = hds0-address;
    inherit rootUrl httpPort;
    settings = {
      webhook = {
        ALLOWED_HOST_LIST = "*";
      };
    };
  };


  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."_" = {
      listen = [ { port = remotePort; addr = "0.0.0.0"; ssl = false; } ];
      locations."/" = {
        proxyPass = "http://localhost:${toString httpPort}/";
      };
    };
  };

  services.postgresql = {
    authentication = ''
      local gitea all ident map=gitea-users
    '';
    identMap = ''
      gitea-users gitea gitea
    '';
  };

  networking.firewall.allowedTCPPorts = [ remotePort ];

}
