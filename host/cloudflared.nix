{ ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/run/secrets/cloudflare/cert.pem";
    tunnels = {
      "83a282df-9554-4eb1-abc1-8cc55388fa10" = {
        credentialsFile = "/run/secrets/cloudflare/welkin.json";
        default = "http_status:404";
        ingress = {
          "ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
          "welkin.ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
          "auth.welkin.ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
          "firefly.welkin.ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
          "davis.welkin.ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
          "mealie.ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
          "todo.ckgxrg.io" = {
            service = "http://127.0.0.1:8080";
          };
        };
      };
    };
  };
}
