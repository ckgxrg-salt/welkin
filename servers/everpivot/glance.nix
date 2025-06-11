{ ... }:
{
  services.glance = {
    enable = true;
    environmentFile = "/var/secrets/glance/env";
    settings = {
      server = {
        port = 5678;
        address = "127.0.0.1";
        proxied = true;
      };
      theme = {
        background-color = "225 14 15";
        primary-color = "157 47 65";
        contrast-multiplier = 1.1;
      };
      pages = [
        {
          name = "Welkin | Dashboard";
          center-vertically = true;
          show-mobile-header = true;
          head-widgets = [
            {
              type = "search";
              search-engine = "duckduckgo";
              placeholder = "Search...";
            }
          ];
          columns = [
            {
              size = "small";
              widgets = [
                # Time bar
                {
                  type = "group";
                  widgets = [
                    {
                      type = "custom-api";
                      title = "Day";
                      body-type = "string";
                      skip-json-validation = true;
                      cache = "1s";
                      template = ''
                        {{ $localTime := now }}
                        {{ $secondsPerDay := 86400 }}
                        {{ $elapsedSeconds := add (mul $localTime.Hour 3600) (mul $localTime.Minute 60) | add $localTime.Second }}
                        {{ $dayProgress := div (mul $elapsedSeconds 100.0) $secondsPerDay }}

                        {{ $gradient := "" }}
                        {{ if lt $dayProgress 10.0 }}
                          {{ $gradient = "#70a1ff" }}
                        {{ else if lt $dayProgress 25.0 }}
                          {{ $gradient = "#ff6b6b, #70a1ff" }}
                        {{ else if lt $dayProgress 50.0 }}
                          {{ $gradient = "#ff6b6b, #f8e71c, #7ed6df" }}
                        {{ else }}
                          {{ $gradient = "#ff6b6b, #f8e71c, #7ed6df, #70a1ff" }}
                        {{ end }}

                        <div style="font-family: sans-serif; text-align: center;">
                          <div style="width: 100%; height: 12px; background: #23262F; border:1px solid gray; border-radius: 10px; overflow: hidden;">
                            <div style="
                              height: 100%;
                              width: {{ $dayProgress }}%;
                              background: linear-gradient(90deg, {{ $gradient }});
                            "></div>
                          </div>
                          <div class="size-h1" style="margin-top: 6px;">{{ printf "%.2f" $dayProgress }}% of the day has passed</div>
                        </div>
                      '';
                    }
                    {
                      type = "custom-api";
                      title = "Month";
                      body-type = "string";
                      skip-json-validation = true;
                      cache = "1s";
                      template = ''
                        {{ $localTime := now }}

                        {{ $month := $localTime.Month }}
                        {{ $dayOfMonth := $localTime.Day }}

                        {{ $secondsToday := add (mul $localTime.Hour 3600) (mul $localTime.Minute 60) | add $localTime.Second }}
                        {{ $fractionOfDay := div $secondsToday 86400.0 }}

                        {{ $daysInMonth := 31 }}
                        {{ if eq $month 2 }} {{ $daysInMonth = 28 }} {{ end }}
                        {{ if or (eq $month 4) (eq $month 6) (eq $month 9) (eq $month 11) }} {{ $daysInMonth = 30 }} {{ end }}

                        {{ $daysElapsed := add (sub $dayOfMonth 1) $fractionOfDay }}
                        {{ $monthProgress := mul (div $daysElapsed $daysInMonth) 100.0 }}

                        {{ $gradient := "" }}
                        {{ if lt $monthProgress 10.0 }}
                          {{ $gradient = "#70a1ff" }}
                        {{ else if lt $monthProgress 25.0 }}
                          {{ $gradient = "#ff6b6b, #70a1ff" }}
                        {{ else if lt $monthProgress 50.0 }}
                          {{ $gradient = "#ff6b6b, #f8e71c, #7ed6df" }}
                        {{ else }}
                          {{ $gradient = "#ff6b6b, #f8e71c, #7ed6df, #70a1ff" }}
                        {{ end }}

                        <div style="font-family: sans-serif; text-align: center;">
                          <div style="width: 100%; height: 12px; background: #23262F; border:1px solid gray; border-radius: 10px; overflow: hidden;">
                            <div style="
                              height: 100%;
                              width: {{ $monthProgress }}%;
                              background: linear-gradient(90deg, {{ $gradient }});
                            "></div>
                          </div>
                          <div class="size-h1" style="margin-top: 6px;">{{ printf "%.2f" $monthProgress }}% of the month has passed</div>
                        </div>
                      '';
                    }
                    {
                      type = "custom-api";
                      title = "Year";
                      body-type = "string";
                      skip-json-validation = true;
                      cache = "1s";
                      template = ''
                        {{ $localTime := now }}

                        {{ $secondsToday := add (mul $localTime.Hour 3600) (mul $localTime.Minute 60) | add $localTime.Second }}
                        {{ $dayOfYear := $localTime.YearDay }}
                        {{ $secondsElapsed := add (mul (sub $dayOfYear 1) 86400) $secondsToday }}

                        {{ $totalSecondsInYear := mul 365 86400 }}
                        {{ $yearProgress := div (mul $secondsElapsed 100.0) $totalSecondsInYear }}

                        {{ $gradient := "" }}
                        {{ if lt $yearProgress 10.0 }}
                          {{ $gradient = "#70a1ff" }}
                        {{ else if lt $yearProgress 25.0 }}
                          {{ $gradient = "#ff6b6b, #70a1ff" }}
                        {{ else if lt $yearProgress 50.0 }}
                          {{ $gradient = "#ff6b6b, #f8e71c, #7ed6df" }}
                        {{ else }}
                          {{ $gradient = "#ff6b6b, #f8e71c, #7ed6df, #70a1ff" }}
                        {{ end }}

                        <div style="font-family: sans-serif; text-align: center;">
                          <div style="width: 100%; height: 12px; background: #23262F; border:1px solid gray; border-radius: 10px; overflow: hidden;">
                            <div style="
                              height: 100%;
                              width: {{ $yearProgress }}%;
                              background: linear-gradient(90deg, {{ $gradient }});
                            "></div>
                          </div>
                          <div class="size-h1" style="margin-top: 6px;">{{ printf "%.2f" $yearProgress }}% of the year has passed</div>
                        </div>
                      '';
                    }
                  ];
                }
                {
                  type = "custom-api";
                  title = "Useless Facts";
                  cache = "6h";
                  url = "https://uselessfacts.jsph.pl/api/v2/facts/random";
                  template = ''<p class=" size-h4 color-paragraph ">{{ .JSON.String " text " }}</p>"'';
                }
                {
                  type = "custom-api";
                  title = "Today's Meal";
                  cache = "1m";
                  url = "https://mealie.welkin.ckgxrg.io/api/households/mealplans/today";
                  headers.Authorization = "Bearer \${MEALIE_TOKEN}";
                  template = ''
                    <div class="flex gap-15 justify-between">
                      {{ range .JSON.Array "" }}
                        <div class="card widget-content-frame flex-1" style="min-width: 0; max-width: calc(50% - 7.5px);">
                          <div class="absolute" style="top: 10px; left: 10px; background-color: var(--color-widget-background); padding: 4px 8px; border-radius: var(--border-radius); z-index: 1;">
                            <span class="size-h5 uppercase color-primary">{{.String "entryType"}}</span>
                          </div>
                          <div class="relative" style="height: 180px; overflow: hidden; border-radius: var(--border-radius) var(--border-radius) 0 0;">
                            <img src="http://mealie.welkin.ckgxrg.io/api/media/recipes/{{.String "recipeId"}}/images/original.webp" 
                                class="max-width-100" style="width: 100%; height: 100%; object-fit: cover;"/>
                          </div>
                          <div class="padding-block-5 padding-inline-widget">
                            <h3 class="size-h3 color-highlight margin-block-5 text-truncate">{{.String "recipe.name"}}</h3>
                          </div>
                        </div>
                      {{ else }}
                        <p class="text-center color-subdue padding-block-5 flex-1">No meals planned for today</p>
                      {{ end }}
                    </div>
                  '';
                }
                {
                  type = "calendar";
                }
                {
                  type = "weather";
                  hour-format = "24h";
                  location = "\${LOCATION}";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "split-column";
                  widgets = [
                    {
                      type = "dns-stats";
                      service = "adguard";
                      allow-insecure = true;
                      url = "http://Everpivot:3000";
                      username = "";
                      password = "";
                    }
                    {
                      type = "server-stats";
                      servers = [
                        {
                          type = "local";
                          name = "Welkin";
                        }
                      ];
                    }
                  ];
                }
                {
                  type = "custom-api";
                  title = "RSS Feeds";
                  url = "https://welkin.ckgxrg.io/miniflux/v1/categories/2/entries?limit=10&order=published_at&direction=desc&category_id=2&status=unread";
                  cache = "15m";
                  headers = {
                    X-Auth-Token = "\${MINIFLUX_TOKEN}";
                    Accept = "application/json";
                  };
                  template = ''
                    <ul class="list list-gap-10 collapsible-container" data-collapse-after="5">
                    {{ range .JSON.Array "entries" }}
                      <li>
                          <div class="flex gap-10 row-reverse-on-mobile thumbnail-parent">
                              <div class="grow min-width-0">
                                  <a href="https://welkin.ckgxrg.io/miniflux/unread/category/2/entry/{{ .String "id" }}" class="size-title-dynamic color-primary-if-not-visited" target="_blank" rel="noreferrer">{{ .String "title" }}</a>
                                  <ul class="list-horizontal-text flex-nowrap text-compact">
                                      <li class="shrink-0">{{ .String "feed.title" }}</li>
                                      <li class="shrink-0" {{ .String "published_at" | parseTime "rfc3339" | toRelativeTime }}></li>
                                      <li class="min-width-0"><a class="visited-indicator text-truncate block" href="{{ .String "url" | safeURL }}" target="_blank" rel="noreferrer" title="Link">Link</a></li>
                                  </ul>
                              </div>
                          </div>
                      </li>
                    {{ end }}
                    </ul>
                  '';
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "custom-api";
                      title = "Oceanblock";
                      url = "https://api.mcstatus.io/v2/status/java/goatfold.ckgxrg.io";
                      cache = "1m";
                      template = ''
                        <div style="display:flex; align-items:center; gap:12px;">
                          <div style="width:40px; height:40px; flex-shrink:0;  border-radius:4px; display:flex; justify-content:center; align-items:center; overflow:hidden;">
                            {{ if .JSON.Bool "online" }}
                              <img src="{{ .JSON.String "icon" | safeURL }}" width="64" height="64" style="object-fit:contain;">
                            {{ else }}
                              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" style="width:32px; height:32px; opacity:0.5;">
                                <path fill-rule="evenodd" d="M1 5.25A2.25 2.25 0 0 1 3.25 3h13.5A2.25 2.25 0 0 1 19 5.25v9.5A2.25 2.25 0 0 1 16.75 17H3.25A2.25 2.25 0 0 1 1 14.75v-9.5Zm1.5 5.81v3.69c0 .414.336.75.75.75h13.5a.75.75 0 0 0 .75-.75v-2.69l-2.22-2.219a.75.75 0 0 0-1.06 0l-1.91 1.909.47.47a.75.75 0 1 1-1.06 1.06L6.53 8.091a.75.75 0 0 0-1.06 0l-2.97 2.97ZM12 7a1 1 0 1 1-2 0 1 1 0 0 1 2 0Z" clip-rule="evenodd" />
                              </svg>
                            {{ end }}
                          </div>

                          <div style="flex-grow:1; min-width:0;">
                            <a class="size-h4 block text-truncate color-highlight">
                              {{ .JSON.String "host" }}
                              {{ if .JSON.Bool "online" }}
                              <span
                                style="width: 8px; height: 8px; border-radius: 50%; background-color: var(--color-positive); display: inline-block; vertical-align: middle;"
                                data-popover-type="text"
                                data-popover-text="Online"
                              ></span>
                              {{ else }}
                              <span
                                style="width: 8px; height: 8px; border-radius: 50%; background-color: var(--color-negative); display: inline-block; vertical-align: middle;"
                                data-popover-type="text"
                                data-popover-text="Offline"
                              ></span>
                              {{ end }}
                            </a>

                            <ul class="list-horizontal-text">
                              <li>
                                {{ if .JSON.Bool "online" }}
                                <span>{{ .JSON.String "version.name_clean" }}</span>
                                {{ else }}
                                <span>Offline</span>
                                {{ end }}
                              </li>
                              {{ if .JSON.Bool "online" }}
                              <li data-popover-type="html">
                                <div data-popover-html>
                                  {{ range .JSON.Array "players.list" }}{{ .String "name_clean" }}<br>{{ end }}
                                </div>
                                <p style="display:inline-flex;align-items:center;">
                                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6" style="height:1em;vertical-align:middle;margin-right:0.5em;">
                                    <path fill-rule="evenodd" d="M7.5 6a4.5 4.5 0 1 1 9 0 4.5 4.5 0 0 1-9 0ZM3.751 20.105a8.25 8.25 0 0 1 16.498 0 .75.75 0 0 1-.437.695A18.683 18.683 0 0 1 12 22.5c-2.786 0-5.433-.608-7.812-1.7a.75.75 0 0 1-.437-.695Z" clip-rule="evenodd" />
                                  </svg>
                                  {{ .JSON.Int "players.online" | formatNumber }}/{{ .JSON.Int "players.max" | formatNumber }} players
                                </p>
                              </li>
                              {{ else }}
                              <li>
                                <p style="display:inline-flex;align-items:center;">
                                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6" style="height:1em;vertical-align:middle;margin-right:0.5em;opacity:0.5;">
                                    <path fill-rule="evenodd" d="M7.5 6a4.5 4.5 0 1 1 9 0 4.5 4.5 0 0 1-9 0ZM3.751 20.105a8.25 8.25 0 0 1 16.498 0 .75.75 0 0 1-.437.695A18.683 18.683 0 0 1 12 22.5c-2.786 0-5.433-.608-7.812-1.7a.75.75 0 0 1-.437-.695Z" clip-rule="evenodd" />
                                  </svg>
                                  0 players
                                </p>
                              </li>
                              {{ end }}
                            </ul>
                          </div>
                        </div>
                      '';
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "monitor";
                  cache = "30m";
                  title = "Everlight Pivot";
                  basic-auth = {
                    username = "\${MONITOR_USERNAME}";
                    password = "\${MONITOR_PWD}";
                  };
                  sites = [
                    {
                      title = "Filebrowser";
                      icon = "si:files";
                      url = "https://welkin.ckgxrg.io/files";
                    }
                    {
                      title = "Syncthing";
                      icon = "si:syncthing";
                      url = "https://welkin.ckgxrg.io/sync";
                    }
                    {
                      title = "Jellyfin";
                      icon = "si:jellyfin";
                      url = "https://welkin.ckgxrg.io/jellyfin";
                    }
                    {
                      title = "LinkWarden";
                      icon = "si:bookmeter";
                      url = "https://welkin.ckgxrg.io/bookmarks";
                    }
                    {
                      title = "AdGuard Home";
                      icon = "si:adguard";
                      allow-insecure = true;
                      url = "http://Everpivot:3000";
                    }
                  ];
                }
                {
                  type = "monitor";
                  cache = "30m";
                  title = "Paralace";
                  basic-auth = {
                    username = "\${MONITOR_USERNAME}";
                    password = "\${MONITOR_PWD}";
                  };
                  sites = [
                    {
                      title = "Davis";
                      icon = "si:googlecalendar";
                      url = "https://davis.welkin.ckgxrg.io";
                    }
                    {
                      title = "Firefly III";
                      icon = "si:fireflyiii";
                      url = "https://firefly.welkin.ckgxrg.io";
                    }
                    {
                      title = "Mealie";
                      icon = "si:mealie";
                      url = "https://mealie.welkin.ckgxrg.io";
                    }
                    {
                      title = "Miniflux";
                      icon = "si:rss";
                      url = "https://welkin.ckgxrg.io/miniflux";
                    }
                    {
                      title = "Vikunja";
                      icon = "si:todoist";
                      url = "https://todo.welkin.ckgxrg.io";
                    }
                  ];
                }
                {
                  type = "monitor";
                  cache = "30m";
                  title = "Archiva";
                  sites = [
                    {
                      title = "Gitea";
                      icon = "si:gitea";
                      url = "https://archiva.ckgxrg.io";
                    }
                  ];
                }
                {
                  type = "monitor";
                  cache = "30m";
                  title = "Stargazer";
                  sites = [
                    {
                      title = "Matrix";
                      icon = "si:matrix";
                      url = "https://stargazer.ckgxrg.io";
                      alt-status-codes = [ 403 ];
                    }
                    {
                      title = "Matrix-QQ";
                      icon = "si:qq";
                      url = "https://stargazer.ckgxrg.io";
                      alt-status-codes = [ 403 ];
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };

  services.frp.settings.proxies = [
    {
      name = "glance";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 5678;
      remotePort = 7102;
    }
  ];
}
