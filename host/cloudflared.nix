{ ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/run/secrets/cloudflare/cert.pem";
    tunnels = {
      "4988884d-28f1-4e86-b777-734e025b5da6" = {
        credentialsFile = "/run/secrets/cloudflare/welkin.json";
        default = "http_status:404";
        ingress = {
          "welkin.ckgxrg.io" = {
            service = "http://localhost:80";
          };
        };
      };
    };
  };
}
