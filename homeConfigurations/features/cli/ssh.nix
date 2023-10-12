let

  builders = __listToAttrs (map (n: {
    name = "b${toString n}";
    value = {
      hostname = "10.10.100.${toString n}";
    };
  } ) [ 3 4 5 7 8]);


  hpc-nodes = __listToAttrs (map (n: {
    name = "n${toString n}";
    value = {
      port = 2220 + n;
      user = "hds";
      hostname = "20.20.100.1";
    };
  }) [ 1 2 3 4 5 ]);


in
{

  programs.ssh = {

    enable = true;
    controlMaster = "auto";
    controlPersist = "30d";
    matchBlocks = {

      "gateway" = {
        forwardX11 = true;
        hostname = "10.10.0.1";
        user = "jj";
      };

      "urubamba" = {
        forwardX11 = true;
        hostname = "10.10.0.2";
        user = "jj";
      };

      "lima" = {
        forwardX11 = true;
        hostname = "10.10.0.21";
        user = "jj";
      };

      "bogota" = {
        forwardX11 = true;
        hostname = "10.10.0.22";
      };

      "lapaz" = {
        forwardX11 = true;
        hostname = "10.10.0.23";
      };

      "antofagasta" = {
        forwardX11 = true;
        hostname = "10.10.0.24";
      };

      "gitdosa" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/id_haedosa";
      };

      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };

      "wavelab" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/id_wavetojj";
      };

      "wavehub" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_wavetojj";
      };

      "hproxy" = {
        forwardX11 = true;
        hostname = "20.20.100.1";
      };

      "hserver" = {
        forwardX11 = true;
        hostname = "20.20.100.2";
      };

      "hproxy2220" = {
        forwardX11 = true;
        hostname = "20.20.100.1";
        port = 2220;
        user = "solma";
      };

      "gitea" = {
        hostname = "20.20.1.1";
        proxyJump = "hproxy2220";
        user = "solma";
      };

    }
    // builders
    // hpc-nodes;

  };


}
