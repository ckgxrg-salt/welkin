# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:
let
  environment = {
    BACKEND_PORT = "8016";
    BODY_SIZE_LIMIT = "Infinity";
    CSRF_TRUSTED_ORIGINS = "http://localhost:8016,http://localhost:8015";
    DISABLE_REGISTRATION = "True";
    FRONTEND_PORT = "8015";
    FRONTEND_URL = "https://trips.welkin.ckgxrg.io";
    PGHOST = "db";
    POSTGRES_DB = "database";
    POSTGRES_USER = "adventure";
    PUBLIC_SERVER_URL = "http://server:8000";
    PUBLIC_URL = "https://trips.welkin.ckgxrg.io";
  };
in
{
  services.frp.settings.proxies = [
    {
      name = "adventurelog";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8015;
      remotePort = 7600;
    }
    {
      name = "adventurelog-admin";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8016;
      remotePort = 7601;
    }
  ];

  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman*".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."adventurelog-backend" = {
    image = "ghcr.nju.edu.cn/seanmorley15/adventurelog-backend:latest";
    inherit environment;
    environmentFiles = [ "/var/secrets/adventurelog/env" ];
    ports = [
      "8016:80/tcp"
    ];
    volumes = [
      "adventurelog_adventurelog_media:/code/media:rw"
    ];
    dependsOn = [
      "adventurelog-db"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=server"
      "--network=adventurelog_default"
    ];
  };
  systemd.services."podman-adventurelog-backend" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-adventurelog_default.service"
      "podman-volume-adventurelog_adventurelog_media.service"
    ];
    requires = [
      "podman-network-adventurelog_default.service"
      "podman-volume-adventurelog_adventurelog_media.service"
    ];
    partOf = [
      "podman-compose-adventurelog-root.target"
    ];
    wantedBy = [
      "podman-compose-adventurelog-root.target"
    ];
  };
  virtualisation.oci-containers.containers."adventurelog-db" = {
    image = "dockerproxy.net/postgis/postgis:16-3.5";
    inherit environment;
    environmentFiles = [ "/var/secrets/adventurelog/env" ];
    volumes = [
      "adventurelog_postgres_data:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=db"
      "--network=adventurelog_default"
    ];
  };
  systemd.services."podman-adventurelog-db" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-adventurelog_default.service"
      "podman-volume-adventurelog_postgres_data.service"
    ];
    requires = [
      "podman-network-adventurelog_default.service"
      "podman-volume-adventurelog_postgres_data.service"
    ];
    partOf = [
      "podman-compose-adventurelog-root.target"
    ];
    wantedBy = [
      "podman-compose-adventurelog-root.target"
    ];
  };
  virtualisation.oci-containers.containers."adventurelog-frontend" = {
    image = "ghcr.nju.edu.cn/seanmorley15/adventurelog-frontend:latest";
    inherit environment;
    environmentFiles = [ "/var/secrets/adventurelog/env" ];
    ports = [
      "8015:3000/tcp"
    ];
    volumes = [
      "adventurelog_postgres_data:/var/lib/postgresql/data:rw"
    ];
    dependsOn = [
      "adventurelog-backend"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=web"
      "--network=adventurelog_default"
    ];
  };
  systemd.services."podman-adventurelog-frontend" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-adventurelog_default.service"
    ];
    requires = [
      "podman-network-adventurelog_default.service"
    ];
    partOf = [
      "podman-compose-adventurelog-root.target"
    ];
    wantedBy = [
      "podman-compose-adventurelog-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-adventurelog_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f adventurelog_default";
    };
    script = ''
      podman network inspect adventurelog_default || podman network create adventurelog_default
    '';
    partOf = [ "podman-compose-adventurelog-root.target" ];
    wantedBy = [ "podman-compose-adventurelog-root.target" ];
  };

  # Volumes
  systemd.services."podman-volume-adventurelog_adventurelog_media" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect adventurelog_adventurelog_media || podman volume create adventurelog_adventurelog_media
    '';
    partOf = [ "podman-compose-adventurelog-root.target" ];
    wantedBy = [ "podman-compose-adventurelog-root.target" ];
  };
  systemd.services."podman-volume-adventurelog_postgres_data" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect adventurelog_postgres_data || podman volume create adventurelog_postgres_data
    '';
    partOf = [ "podman-compose-adventurelog-root.target" ];
    wantedBy = [ "podman-compose-adventurelog-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-adventurelog-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
