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
            service = "http://127.0.0.1:80";
          };
          "archiva.ckgxrg.io" = {
            service = "http://10.7.0.2:7200";
          };
          "alumnimap.ckgxrg.io" = {
            service = "http://10.7.0.2:7201";
          };
          "stargazer.ckgxrg.io" = {
            service = "http://10.7.0.4:7400";
          };
        };
      };
    };
  };
}
