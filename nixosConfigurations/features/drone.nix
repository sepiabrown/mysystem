{ config, pkgs, ... }:
let
  # ref: https://ayats.org/blog/gitea-drone

  droneserver = config.users.users.droneserver.name;
  port = 3030;
in
{

  networking.firewall.allowedTCPPorts = [ 80 3030 ];

  users.users.droneserver = {
    isSystemUser = true;
    createHome = true;
    group = droneserver;
  };
  users.groups.droneserver = { };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
  };

  services.nginx.virtualHosts."_" = {
    locations."/".proxyPass = "http://localhost:${toString port}/";
    locations."/notes".proxyPass = "http://localhost:30000/";
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ droneserver ];
    ensureUsers = [{
      name = droneserver;
      ensurePermissions = {
        "DATABASE ${droneserver}" = "ALL PRIVILEGES";
      };
    }];
  };

  # Secrets configured are defined in the age file
  # - DRONE_GITEA_CLIENT_ID
  # - DRONE_GITEA_CLIENT_SECRET
  # - DRONE_RPC_SECRET
  # To get these secrets, please check Drone's documentation for Gitea integration:
  # https://docs.drone.io/server/provider/gitea/
  age.secrets.drone = {
    file = ../../secrets/drone.age;
    mode = "770";
    owner = droneserver;
    group = droneserver;
  };

  systemd.services.drone-server = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = [
        config.age.secrets.drone.path
      ];
      Environment = [
        "DRONE_DATABASE_DATASOURCE=postgres:///droneserver?host=/run/postgresql"
        "DRONE_DATABASE_DRIVER=postgres"
        "DRONE_SERVER_PORT=:${toString port}"
        "DRONE_USER_CREATE=username:drone,admin:true" # set your admin username

        "DRONE_GITEA_SERVER=http://10.10.0.21:30001"
        "DRONE_SERVER_HOST=10.10.0.25"
        "DRONE_SERVER_PROTO=http"
      ];
      ExecStart = "${pkgs.drone}/bin/drone-server";
      User = droneserver;
      Group = droneserver;
    };
  };

  ### Exec runner

  users.users.drone-runner-exec = {
    isSystemUser = true;
    group = "drone-runner-exec";
  };
  users.groups.drone-runner-exec = { };
  # Allow the exec runner to write to build with nix
  nix.settings.allowed-users = [ "drone-runner-exec" ];

  systemd.services.drone-runner-exec = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    ### MANUALLY RESTART SERVICE IF CHANGED
    restartIfChanged = true;
    confinement.enable = true;
    confinement.packages = [
      pkgs.git
      pkgs.gnutar
      pkgs.bash
      pkgs.nixFlakes
      pkgs.gzip
    ];
    path = [
      pkgs.git
      pkgs.gnutar
      pkgs.bash
      pkgs.nixFlakes
      pkgs.gzip
    ];
    serviceConfig = {
      Environment = [
        "DRONE_RPC_PROTO=http"
        "DRONE_RPC_HOST=127.0.0.1:${toString port}"
        "DRONE_RUNNER_CAPACITY=2"
        "DRONE_RUNNER_NAME=drone-runner-exec"
        "NIX_REMOTE=daemon"
        "PAGER=cat"
        "DRONE_DEBUG=true"
      ];
      BindPaths = [
        "/nix/var/nix/daemon-socket/socket"
        "/run/nscd/socket"
        # "/var/lib/drone"
      ];
      BindReadOnlyPaths = [
        "/etc/passwd:/etc/passwd"
        "/etc/group:/etc/group"
        "/nix/var/nix/profiles/system/etc/nix:/etc/nix"
        "${config.environment.etc."ssl/certs/ca-certificates.crt".source}:/etc/ssl/certs/ca-certificates.crt"
        "${config.environment.etc."ssh/ssh_known_hosts".source}:/etc/ssh/ssh_known_hosts"
        "${builtins.toFile "ssh_config" ''
          Host 10.10.0.25
          ForwardAgent yes
        ''}:/etc/ssh/ssh_config"
        "/etc/machine-id"
        "/etc/resolv.conf"
        "/nix/"
      ];
      EnvironmentFile = [
        config.age.secrets.drone.path
      ];
      ExecStart = "${pkgs.drone-runner-exec}/bin/drone-runner-exec";
      User = "drone-runner-exec";
      Group = "drone-runner-exec";
    };
  };
}
