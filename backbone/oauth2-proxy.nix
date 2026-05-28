{ ... }:
{
  services.oauth2-proxy = {
    enable = true;
    httpAddress = "http://127.0.0.1:7001";
    reverseProxy = true;
    trustedProxyIP = [ "127.0.0.1" ];

    email = {
      domains = [ "ckgxrg.io" ];
    };
    cookie = {
      domain = ".ckgxrg.io";
      secretFile = "/run/secrets/oauth2-proxy/cookie-secret";
    };

    provider = "keycloak-oidc";
    approvalPrompt = "auto";
    clientID = "oauth2-proxy";
    clientSecretFile = "/run/secrets/oauth2-proxy/client-secret";
    redirectURL = "https://welkin.ckgxrg.io/oauth2/callback";
    oidcIssuerUrl = "https://welkin.ckgxrg.io/auth/realms/master";

    extraConfig = {
      code-challenge-method = "S256";
      provider-display-name = "Welkin";
    };
  };
}
