{ ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/var/secrets/cloudflare/cert.pem";
    tunnels = {
      "40d3834b-050f-493c-b2ec-1f9c0c642d2b" = {
        credentialsFile = "/var/secrets/cloudflare/stargazer.json";
        default = "http_status:404";
        ingress = {
          "stargazer.ckgxrg.io" = {
            service = "http://127.0.0.1:8008";
          };
        };
      };
    };
  };
}
