{ config, lib, pkgs, ... }:
let

  inherit (lib) mkEnableOption mkOption types mkIf;

  cfg = config.services.frps;

  configFile = pkgs.writeText "frps.ini" ''
    [common]
    bind_port = ${toString cfg.bindPort}
    vhost_http_port = ${toString cfg.httpPort}
    bind_udp_port = ${toString cfg.udpPort}
  '';

in
{

  options.services.frps = {

    enable = mkEnableOption "frp server";

    package = mkOption {
      type = types.package;
      default = pkgs.frp;
    };

    bindPort = mkOption {
      type = types.port;
      default = 7070;
      description = lib.mdDoc ''
        Port number where frp bind to.
      '';
    };

    httpPort = mkOption {
      type = types.port;
      default = 8080;
      description = lib.mdDoc ''
        Port number to expose HTTP(S).
      '';
    };

    udpPort = mkOption {
      type = types.port;
      default = 7071;
      description = lib.mdDoc ''
        Port number to expose UDP.
      '';
    };

  };


  config = mkIf cfg.enable {

    systemd.services.frps = {

      description = "fast reverse proxy server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      path = [ ];

      script = ''
        exec ${cfg.package}/bin/frps -c ${configFile}
      '';

      serviceConfig = {
        Restart = "always";
        RestartSec = "5s";
        User = "frp";
        Group = "frp";
        DynamicUser = true;
      };

    };

    networking.firewall.allowedTCPPorts = [ cfg.bindPort cfg.httpPort ];
    networking.firewall.allowedUDPPorts = [ cfg.bindPort cfg.udpPort ];

  };

}
