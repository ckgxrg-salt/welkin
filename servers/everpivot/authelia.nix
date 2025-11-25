{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 7100 ];

  services.authelia.instances."Welkin" = {
    enable = true;
    user = "authelia";
    group = "authelia";
    secrets = {
      jwtSecretFile = "/var/secrets/authelia/jwt";
      sessionSecretFile = "/var/secrets/authelia/session";
      storageEncryptionKeyFile = "/var/secrets/authelia/storage";
      oidcHmacSecretFile = "/var/secrets/authelia/hmac";
      oidcIssuerPrivateKeyFile = "/var/secrets/authelia/oidc-issuer";
    };
    environmentVariables = {
      AUTHELIA_STORAGE_POSTGRES_PASSWORD_FILE = "/var/secrets/authelia/dbpasswd";
    };
    settings = {
      server = {
        address = "tcp://:7100";
        asset_path = "/var/lib/authelia-Welkin/assets";
        endpoints.authz.forward-auth.implementation = "ForwardAuth";
      };
      theme = "dark";
      authentication_backend = {
        password_reset.disable = true;
        password_change.disable = true;
        file = {
          path = "/var/secrets/authelia/users.yaml";
          password.algorithm = "argon2";
        };
      };
      access_control = {
        default_policy = "deny";
        rules = [
          {
            domain = "welkin.ckgxrg.io";
            policy = "one_factor";
            subject = [
              "group:admin"
            ];
          }
          {
            domain = "firefly.welkin.ckgxrg.io";
            policy = "one_factor";
            subject = [
              "group:admin"
              "group:firefly"
            ];
          }
        ];
      };
      identity_providers.oidc = {
        clients = [
          {
            client_id = "jellyfin";
            client_secret = "$pbkdf2-sha512$310000$mkRcEYKEO9PyUplyfCtUmg$E9G4781j4AiMMmpmAwICsF69tY0zbhv99Y8WRQSrDn92XZgORBX/dQmAJ3kOCjFHaGZaZxT.E531nUMCWh9idw";
            client_name = "Jellyfin";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://welkin.ckgxrg.io/jellyfin/sso/OID/redirect/authelia" ];
            scopes = [
              "openid"
              "profile"
              "groups"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_post";
          }
          {
            client_id = "gitea";
            client_secret = "$pbkdf2-sha512$310000$Re0xJIX9hI7TKtgsYc306w$43Z.l5T3Jo2ty8QRq.LSmAwQ0Z/7JUOHsYy92jcDlW36VpJdRU77BjjnGfT/e5C9.tiIEeMFLiiea/QY/.n67Q";
            client_name = "Gitea";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://archiva.ckgxrg.io/user/oauth2/Welkin/callback" ];
            scopes = [
              "openid"
              "email"
              "profile"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
          {
            client_id = "mealie";
            client_secret = "$pbkdf2-sha512$310000$.4z4aG.rGjNuqRieKKQ69Q$a3trExILXestrXn0mH2v0KfBSCrJXmOkKt1v5G6eM5KunHwsO2gC/UZW0nYPYgEYzx66HeyoN3pYkVbau3Zm4A";
            client_name = "Mealie";
            authorization_policy = "one_factor";
            redirect_uris = [
              "https://mealie.welkin.ckgxrg.io/login"
              # Strange bug
              "http://mealie.welkin.ckgxrg.io/login"
            ];
            scopes = [
              "openid"
              "email"
              "profile"
              "groups"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
          {
            client_id = "miniflux";
            client_secret = "$pbkdf2-sha512$310000$6Pc6L/0c58.EoViD8jyKVw$9XE7vgDzyEZHGg0xua6KMgDWwq4k1z3NEQIuxAWg.YXACFqgTmfrhYsmdPlnxJ0y/a3QvcAIPYpBp.JwKQNEwA";
            client_name = "Miniflux";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://welkin.ckgxrg.io/rss/oauth2/oidc/callback" ];
            scopes = [
              "openid"
              "email"
              "profile"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
          {
            client_id = "paperless";
            client_secret = "$pbkdf2-sha512$310000$dbg.3mzulWQBl6DielCNtg$xt4UYt9wknuPKpcCzXJs2cRaRaYInhtVIw5e7flxuqhMIX8gTByCAXp0SJDDqi1E.PE7iDiKctVV9B99Tq4lnA";
            client_name = "Paperless";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://welkin.ckgxrg.io/docs/accounts/oidc/authelia/login/callback/" ];
            scopes = [
              "openid"
              "email"
              "profile"
              "groups"
            ];
            response_types = [ "code" ];
            grant_types = [ "authorization_code" ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
          {
            client_id = "nextcloud";
            client_secret = "$pbkdf2-sha512$310000$BXB7lJmdeS4vI6FwVUBixg$HRUYNbh3hTUx35Zl5FSNTfeOD2DgLUijskeA2onBPhSNKR1gYZuu4neHwhxgcWoKS0T1rYU9EyilRvN7sg3iGw";
            client_name = "Nextcloud";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://welkin.ckgxrg.io/cloud/apps/sociallogin/custom_oidc/welkin" ];
            scopes = [
              "openid"
              "email"
              "profile"
              "groups"
            ];
            response_types = [ "code" ];
            grant_types = [ "authorization_code" ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_post";
          }
        ];
      };
      session = {
        redis = {
          host = "127.0.0.1";
          port = "6379";
        };
        cookies = [
          {
            domain = "ckgxrg.io";
            authelia_url = "https://auth.welkin.ckgxrg.io";
            default_redirection_url = "https://welkin.ckgxrg.io";
          }
        ];
      };
      storage = {
        postgres = {
          address = "tcp://127.0.0.1:5432";
          database = "authelia";
          username = "authelia";
        };
      };
      notifier = {
        filesystem.filename = "/var/lib/authelia-Welkin/notifications.txt";
      };
    };
  };

  users = {
    users."authelia" = {
      description = "Authelia user";
      isSystemUser = true;
      group = "authelia";
      extraGroups = [ "secrets" ];
    };
    groups."authelia" = { };
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "authelia";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "authelia" ];
  };
}
