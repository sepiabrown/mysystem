{

  programs.ssh = {

    enable = true;
    matchBlocks = {

      "gateway" = {
        forwardX11 = true;
        hostname = "121.136.244.64";
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

      "b1" = {
        forwardX11 = true;
        hostname = "10.10.100.1";
      };

      "b2" = {
        forwardX11 = true;
        hostname = "10.10.100.2";
      };

      "b3" = {
        forwardX11 = true;
        hostname = "10.10.100.3";
      };

      "b4" = {
        forwardX11 = true;
        hostname = "10.10.100.4";
      };

      "b5" = {
        forwardX11 = true;
        hostname = "10.10.100.5";
      };

      "b6" = {
        forwardX11 = true;
        hostname = "10.10.100.6";
      };

      "hproxy" = {
        forwardX11 = true;
        hostname = "20.20.100.1";
      };

      "hserver" = {
        forwardX11 = true;
        hostname = "20.20.100.2";
      };

      "h6" = {
        forwardX11 = true;
        hostname = "20.20.100.6";
      };
    };

  };


}
