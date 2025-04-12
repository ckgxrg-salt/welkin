{ pkgs, ... }:
# Matrix-QQ bridge
let
  pkg = (pkgs.callPackage ../../misc/matrix-qq.nix { });
  settingsFile = "/var/lib/matrix-qq/settings.yaml";
  registrationFile = "/var/lib/matrix-qq/qq-registration.yaml";
in
{
  environment.systemPackages = [
    pkg
    pkgs.ffmpeg
  ];
  users = {
    users."matrix-qq" = {
      isSystemUser = true;
      group = "matrix-qq";
      home = "/var/lib/matrix-qq";
      description = "Matrix-QQ bridge user";
    };
    groups."matrix-qq" = { };
  };

  services.matrix-synapse = {
    settings.app_service_config_files = [
      registrationFile
      "/var/lib/matrix-qq/qq-doublepuppet.yaml"
    ];
  };
  systemd.services.matrix-synapse = {
    serviceConfig.SupplementaryGroups = [ "matrix-qq" ];
  };

  systemd.services.matrix-qq = {
    description = "Matrix-QQ puppeting bridge";
    path = [ pkgs.ffmpeg ];
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      User = "matrix-qq";
      Group = "matrix-qq";
      StateDirectory = "matrix-qq";
      WorkingDirectory = "/var/lib/matrix-qq";
      ExecStart = ''
        ${pkg}/bin/matrix-qq \
        --config='${settingsFile}' \
        --registration='${registrationFile}'
      '';
      LockPersonality = true;
      NoNewPrivileges = true;
      PrivateDevices = true;
      PrivateTmp = true;
      PrivateUsers = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectSystem = "strict";
      Restart = "on-failure";
      RestartSec = "30s";
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";
      SystemCallErrorNumber = "EPERM";
      SystemCallFilter = [ "@system-service" ];
      Type = "simple";
      UMask = 27;
    };
  };
}
