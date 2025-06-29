{ ... }:
let
  default = {
    mode = "0440";
    gid = 1437;
  };
in
{
  sops = {
    defaultSopsFile = ./default.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = true;
    };
  };

  sops.secrets = {
    "everpivot/glance/env" = { };
    "everpivot/authelia/jwt" = default;
    "everpivot/authelia/storage" = default;
    "everpivot/authelia/dbpasswd" = default;
    "everpivot/authelia/session" = default;
    "everpivot/authelia/hmac" = default;
    "everpivot/authelia/oidc-issuer" = default;
    "everpivot/authelia/users.yaml" = default // {
      sopsFile = ../secrets/users.yaml;
      key = "";
    };
    "archiva/gitea/dbpasswd" = default;
    "stargazer/continuwuity/registration-token.env" = { };
    "paralace/davis/app-secret" = default;
    "paralace/firefly-iii/app-key" = default;
    "paralace/mealie/client-secret.env" = { };
    "paralace/miniflux/client-secret.env" = { };
    "paralace/vikunja.yaml" = default // {
      sopsFile = ./vikunja.yaml;
      key = "";
    };
    "impure/adventurelog/env" = { };
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
