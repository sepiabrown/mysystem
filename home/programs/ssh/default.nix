{ config, lib, ... }:

{

  # This is probably not a correct way to set this up.
  # The files created this way have permission 777, which
  # is often not the correct permission that has to be set.
  # home.file.".ssh/id_rsa".source = ./id_rsa;
  # home.file.".ssh/id_rsa.pub".source = ./id_rsa.pub;
  # home.file.".ssh/authorized_keys" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ./authorized_keys;
  #   executable = false;
  # };

  programs.ssh = {

    enable = true;
    matchBlocks = {

      "mp" = {
        forwardX11 = true;
        hostname = "100.109.194.18";
        user = "jj";
      };

      "x230" = {
        forwardX11 = true;
        hostname = "100.88.21.60";
        user = "jj";
      };

      "gateway" = {
        forwardX11 = true;
        hostname = "121.136.244.64";
        user = "jj";
      };

      "x1" = {
        forwardX11 = true;
        hostname = "10.10.0.2";
        user = "jj";
      };

      "mirror" = {
        forwardX11 = true;
        hostname = "10.10.0.21";
        user = "jj";
      };

      "legion5" = {
        forwardX11 = true;
        hostname = "10.10.0.22";
      };

      "p15" = {
        forwardX11 = true;
        hostname = "10.10.0.3";
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


      # "builder1" = {
      #   hostname = "10.10.100.1";
      #   user = "root";
      #   identityFile = "~/.ssh/id_builder";
      # };

      # "builder2" = {
      #   hostname = "10.10.100.2";
      #   user = "root";
      #   identityFile = "~/.ssh/id_builder";
      # };

      # "builder1" = {
      #   hostname = "121.136.244.64";
      #   user = "root";
      #   port = 101;
      #   identityFile = "~/.ssh/id_builder";
      # };

      # "builder2" = {
      #   hostname = "121.136.244.64";
      #   user = "root";
      #   port = 102;
      #   identityFile = "~/.ssh/id_builder";
      # };

    };

  };


  # FIXME
  # home.activation.authorizedKeys = dagEntryAfter ["writeBoundary"] ''
  #     install -D -m644 ${./authorized_keys} $HOME/.ssh/authorized_keys
  # '';

}
