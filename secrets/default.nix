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
    "cloudflare/api" = { };
    "cloudflare/cert.pem" = { };
    "cloudflare/welkin.json" = { };

    "glance/env" = { };
    "paperless/admin-pass" = default;
    "paperless/env" = default;
    "tuwunel/env" = { };
    "matrix-whatsapp/env" = { };
    "firefly-iii/app-key" = default;
    "mealie/client-secret.env" = { };
    "miniflux/client-secret.env" = { };
    "nextcloud/admin-pass" = default;
  };
}
