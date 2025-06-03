{ ... }:
{
  sops = {
    defaultSopsFile = ./default.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = true;
    };
  };

  sops.secrets = {
    "everpivot/shiori/env" = { };
    "archiva/gitea/dbpasswd" = {
      uid = 996;
      gid = 995;
    };
    "stargazer/synapse/registration_secret.conf" = {
      uid = 224;
      gid = 224;
    };
    "paralace/davis/admin-passwd" = {
      uid = 996;
      gid = 994;
    };
    "paralace/davis/app-secret" = {
      uid = 996;
      gid = 994;
    };
    "paralace/firefly-iii/app-key" = {
      uid = 995;
      gid = 60;
    };
    "paralace/freshrss/passwd" = {
      uid = 994;
      gid = 992;
    };
  };

  containers = {
    everpivot.bindMounts."secrets" = {
      hostPath = "/run/secrets/everpivot";
      mountPoint = "/var/secrets";
      isReadOnly = true;
    };
    archiva.bindMounts."secrets" = {
      hostPath = "/run/secrets/archiva";
      mountPoint = "/var/secrets";
      isReadOnly = true;
    };
    stargazer.bindMounts."secrets" = {
      hostPath = "/run/secrets/stargazer";
      mountPoint = "/var/secrets";
      isReadOnly = true;
    };
    paralace.bindMounts."secrets" = {
      hostPath = "/run/secrets/paralace";
      mountPoint = "/var/secrets";
      isReadOnly = true;
    };
  };
}
