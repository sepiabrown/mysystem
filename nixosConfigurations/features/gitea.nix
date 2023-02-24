{ config, pkgs, lib, ... }:
let


  hds0-address = __head (lib.splitString "/" (__head config.networking.wireguard.interfaces.hds0.ips));
  httpPort = 3001;
  rootUrl = "http://${hds0-address}/git/";

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
    domain = "git.jjdosa.xyz";
    inherit rootUrl httpPort;
  };


  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."_" = {
      locations."/git/" = {
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

}
