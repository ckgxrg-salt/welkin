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
    "everpivot/authelia/jwt" = {
      uid = 988;
      gid = 986;
    };
    "everpivot/authelia/storage" = {
      uid = 988;
      gid = 986;
    };
    "everpivot/authelia/dbpasswd" = {
      uid = 988;
      gid = 986;
    };
    "everpivot/authelia/session" = {
      uid = 988;
      gid = 986;
    };
    "everpivot/authelia/hmac" = {
      uid = 988;
      gid = 986;
    };
    "everpivot/authelia/oidc-issuer" = {
      uid = 988;
      gid = 986;
    };
    "everpivot/authelia/users.yaml" = {
      uid = 988;
      gid = 986;
      sopsFile = ../secrets/users.yaml;
      key = "";
    };
    "archiva/gitea/dbpasswd" = {
      uid = 996;
      gid = 995;
    };
    "stargazer/synapse/registration-secret.conf" = {
      uid = 224;
      gid = 224;
    };
    "stargazer/synapse/client-secret" = {
      uid = 224;
      gid = 224;
    };
    "paralace/davis/app-secret" = {
      uid = 996;
      gid = 994;
    };
    "paralace/firefly-iii/app-key" = {
      uid = 995;
      gid = 60;
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
