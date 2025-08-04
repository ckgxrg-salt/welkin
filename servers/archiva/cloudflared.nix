{ ... }:
{
  services.cloudflared = {
    enable = true;
    certificateFile = "/var/secrets/cloudflare/cert.pem";
    tunnels = {
      "7d0118ac-fa10-4db8-b6a5-5f6aa6ed247a" = {
        credentialsFile = "/var/secrets/cloudflare/archiva.json";
        default = "http_status:404";
        ingress = {
          "archiva.ckgxrg.io" = {
            service = "http://127.0.0.1:8999";
          };
        };
      };
    };
  };
}
