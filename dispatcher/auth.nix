{ ... }:
{
  services.nginx.virtualHosts =
    let
      autheliaLocation = ''
        set $upstream_authelia http://localhost:7106/api/authz/auth-request;
        location /internal/authelia/authz {
            internal;
            proxy_pass $upstream_authelia;

            proxy_set_header X-Original-Method $request_method;
            proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
            proxy_set_header X-Forwarded-For $remote_addr;
            proxy_set_header Content-Length "";
            proxy_set_header Connection "";

            proxy_pass_request_body off;
            proxy_next_upstream error timeout invalid_header http_500 http_502 http_503; # Timeout if the real server is dead
            proxy_redirect http:// $scheme://;
            proxy_http_version 1.1;
            proxy_cache_bypass $cookie_session;
            proxy_no_cache $cookie_session;
            proxy_buffers 4 32k;
            client_body_buffer_size 128k;

            send_timeout 5m;
            proxy_read_timeout 240;
            proxy_send_timeout 240;
            proxy_connect_timeout 240;
        }
      '';
      autheliaAuthrequest = ''
        auth_request /internal/authelia/authz;

        auth_request_set $user $upstream_http_remote_user;
        auth_request_set $groups $upstream_http_remote_groups;
        auth_request_set $name $upstream_http_remote_name;
        auth_request_set $email $upstream_http_remote_email;

        proxy_set_header Remote-User $user;
        proxy_set_header Remote-Groups $groups;
        proxy_set_header Remote-Email $email;
        proxy_set_header Remote-Name $name;

        auth_request_set $redirection_url $upstream_http_location;
        error_page 401 =302 $redirection_url;
      '';
    in
    {
      "auth.welkin.ckgxrg.io" = {
        useACMEHost = "welkin.ckgxrg.io";
        forceSSL = true;
        listenAddresses = [
          "0.0.0.0"
          "[::0]"
        ];
        locations = {
          "/" = {
            proxyPass = "http://localhost:7106";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Original-URL $scheme://$http_host$request_uri;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Host $http_host;
              proxy_set_header X-Forwarded-URI $request_uri;
              proxy_set_header X-Forwarded-Ssl on;
              proxy_set_header X-Forwarded-For $remote_addr;
              proxy_set_header X-Real-IP $remote_addr;

              client_body_buffer_size 128k;
              proxy_next_upstream error timeout invalid_header http_500 http_502 http_503; ## Timeout if the real server is dead.
              proxy_redirect  http://  $scheme://;
              proxy_http_version 1.1;
              proxy_cache_bypass $cookie_session;
              proxy_no_cache $cookie_session;
              proxy_buffers 64 256k;

              send_timeout 5m;
              proxy_read_timeout 360;
              proxy_send_timeout 360;
              proxy_connect_timeout 360;
            '';
          };
          "/api/verify".proxyPass = "http://localhost:7106";
          "/api/authz/".proxyPass = "http://localhost:7106";
        };
      };
      "welkin.ckgxrg.io" = {
        extraConfig = autheliaLocation;
        locations."/".extraConfig = autheliaAuthrequest;
        locations."/files/".extraConfig = autheliaAuthrequest;
        locations."/sync/".extraConfig = autheliaAuthrequest;
      };
    };
}
