{ ... }:
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 5678;
    allowedHosts = "localhost:5678,welkin.ckgxrg.io";
    environmentFile = "/var/secrets/homepage/env";
    settings = {
      title = "Welkin";
      description = "Welkin - Dashboard";
      theme = "dark";
      color = "slate";
      base = "https://welkin.ckgxrg.io";
      target = "_blank";
      disableUpdateCheck = true;
      disableCollapse = true;

      layout = [
        {
          "Everlight Pivot" = {
            icon = "mdi-sun-angle";
            style = "row";
            columns = 3;
          };
        }
        {
          "Paralace" = {
            icon = "mdi-home-modern";
            style = "row";
            columns = 2;
          };
        }
        {
          "Archiva" = {
            icon = "mdi-briefcase";
          };
        }
        {
          "Goatfold" = {
            icon = "mdi-controller";
          };
        }
        {
          "Stargazer" = {
            icon = "mdi-nfc-tap";
          };
        }
      ];
    };
    widgets = [
      {
        "greeting" = {
          text = "Welkin";
        };
      }
      {
        "search" = {
          provider = "duckduckgo";
          focus = true;
          showSearchSuggestions = true;
          target = "_self";
        };
      }
      {
        "datetime" = {
          format = {
            dateStyle = "long";
            timeStyle = "short";
            hour12 = false;
          };
        };
      }
    ];
    services = [
      {
        "Everlight Pivot" = [
          {
            "Filebrowser" = {
              icon = "mdi-file-account";
              description = "Web-based File Browser";
              href = "https://welkin.ckgxrg.io/files";
            };
          }
          {
            "Syncthing" = {
              icon = "mdi-sync";
              description = "File Synchonisation";
              href = "https://welkin.ckgxrg.io/sync";
            };
          }
          {
            "Jellyfin" = {
              icon = "mdi-multimedia";
              description = "Media Centre";
              href = "https://welkin.ckgxrg.io/jellyfin";
              widgets = [
                {
                  type = "jellyfin";
                  url = "https://welkin.ckgxrg.io/jellyfin";
                  key = "{{HOMEPAGE_VAR_JELLYFIN_TOKEN}}";
                }
              ];
            };
          }
          {
            "LinkWarden" = {
              icon = "mdi-link-box";
              description = "Under Construction";
              href = "https://welkin.ckgxrg.io/bookmarks";
            };
          }
          {
            "AdGuard Home" = {
              icon = "mdi-code-block-braces";
              description = "Only available at home network";
              href = "http://Everpivot:3000";
              widgets = [
                {
                  type = "adguard";
                  url = "http://Everpivot:3000";
                  username = "";
                  password = "";
                }
              ];
            };
          }
        ];
      }
      {
        "Archiva" = [
          {
            "Gitea" = {
              icon = "mdi-git";
              description = "Code & Project Management";
              href = "https://archiva.ckgxrg.io";
              widgets = [
                {
                  type = "gitea";
                  url = "https://archiva.ckgxrg.io";
                  key = "{{HOMEPAGE_VAR_GITEA_TOKEN}}";
                }
              ];
            };
          }
        ];
      }
      {
        "Goatfold" = [
          {
            "Oceanblock" = {
              icon = "mdi-minecraft";
              description = "A Minecraft Servers";
              widgets = [
                {
                  type = "minecraft";
                  url = "udp://home-route.ckgxrg.io:25565";
                }
              ];
            };
          }
        ];
      }
      {
        "Stargazer" = [
          {
            "Matrix Synapse" = {
              icon = "mdi-matrix";
              description = "Synapse Homeserver for Matrix Protocol";
            };
          }
          {
            "Matrix QQ" = {
              icon = "mdi-qqchat";
              description = "QQ Bridge for Matrix Synapse";
            };
          }
        ];
      }
      {
        "Paralace" = [
          {
            "Davis" = {
              icon = "mdi-calendar-account";
              description = "CalDAV & CardDAV Server";
              href = "https://davis.welkin.ckgxrg.io";
            };
          }
          {
            "Firefly III" = {
              icon = "mdi-cash";
              description = "Finance Management";
              href = "https://firefly.welkin.ckgxrg.io";
              widgets = [
                {
                  type = "firefly";
                  url = "https://firefly.welkin.ckgxrg.io";
                  key = "{{HOMEPAGE_VAR_FIREFLY_TOKEN}}";
                }
              ];
            };
          }
          {
            "Mealie" = {
              icon = "mdi-chef-hat";
              description = "Recipes";
              href = "https://mealie.welkin.ckgxrg.io";
              widgets = [
                {
                  type = "mealie";
                  url = "https://mealie.welkin.ckgxrg.io";
                  key = "{{HOMEPAGE_VAR_MEALIE_TOKEN}}";
                  version = 2;
                }
              ];
            };
          }
          {
            "FreshRSS" = {
              icon = "mdi-rss";
              description = "RSS Aggregator & Reader";
              href = "https://freshrss.welkin.ckgxrg.io";
              widgets = [
                {
                  type = "freshrss";
                  url = "https://freshrss.welkin.ckgxrg.io";
                  username = "ckgxrg";
                  password = "{{HOMEPAGE_VAR_FRESHRSS_PWD}}";
                }
              ];
            };
          }
        ];
      }
    ];
  };

  services.frp.settings.proxies = [
    {
      name = "homepage";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 5678;
      remotePort = 7102;
    }
  ];
}
