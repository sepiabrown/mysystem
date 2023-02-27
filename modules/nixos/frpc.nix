{ config, lib, pkgs, ... }:
let

  inherit (lib) mkEnableOption mkOption types mkIf;

  cfg = config.services.frpc;

  configFile = pkgs.writeText "frpc.ini" ''
    [common]
    server_addr = ${toString cfg.serverAddress}
    server_port = ${toString cfg.bindPort}

    [ssh]
    type = tcp
    local_ip = 127.0.0.1
    local_port = 22
    remote_port = ${toString cfg.remoteSSHPort}

    [web]
    type = http
    local_port = 80
    custom_domains = ${cfg.customDomain}
  '';

in
{

  options.services.frpc = {

    enable = mkEnableOption "frp client";

    package = mkOption {
      type = types.package;
      default = pkgs.frp;
    };

    serverAddress = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = lib.mdDoc ''
        IP address of the frp server.
      '';
    };

    bindPort = mkOption {
      type = types.port;
      default = 7070;
      description = lib.mdDoc ''
        Port number where frp bind to.
      '';
    };

    remoteSSHPort = mkOption {
      type = types.port;
      default = 6000;
      description = lib.mdDoc ''
        Port number to expose SSH.
      '';
    };

    customDomain = mkOption {
      type = types.str;
      default = "www.example.com";
      description = lib.mdDoc ''
        Custom domain name
      '';
    };

    remoteHTTPPort = mkOption {
      type = types.port;
      default = 6001;
      description = lib.mdDoc ''
        Port number to expose HTTP.
      '';
    };


  };


  config = {

    systemd.services.frpc = {

      description = "fast reverse proxy client";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        exec ${cfg.package}/bin/frpc -c ${configFile}
      '';

      serviceConfig = {
        Restart = "always";
        RestartSec = "5s";
        User = "frp";
        Group = "frp";
        DynamicUser = true;
      };

    };

    networking.firewall.allowedTCPPorts = [ cfg.bindPort 22 80 ];
    networking.firewall.allowedUDPPorts = [ cfg.bindPort ];

  };

}
