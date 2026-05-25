{ helpers, ... }:
{
  imports = [
    (helpers.mkDB "tandoor_recipes")
  ];

  services.tandoor-recipes = {
    enable = true;
    address = "127.0.0.1";
    port = 7502;
    extraConfig = {
      DB_ENGINE = "django.db.backends.postgresql";
      POSTGRES_HOST = "/run/postgresql";
      POSTGRES_USER = "tandoor_recipes";
      POSTGRES_DB = "tandoor_recipes";

      ALLOWED_HOSTS = "welkin.ckgxrg.io";
      SCRIPT_NAME = "/recipes";
      SOCIAL_PROVIDERS = "allauth.socialaccount.providers.openid_connect";
      SOCIALACCOUNT_AUTO_SIGNUP = 0;
      ENABLE_SIGNUP = 0;
      HIDE_LOGIN_FORM = 1;
      SOCIALACCOUNT_LOGIN_ON_GET = 1;
    };
  };

  systemd.services.tandoor-recipes.serviceConfig.EnvironmentFile = "/run/secrets/tandoor/env";
}
