{ ... }:
{
  config = {
    services.btrfs = {
      autoScrub.enable = true;
    };

    services.snapper =
      let
        enable = {
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
        };
      in
      {
        snapshotInterval = "hourly";
        cleanupInterval = "daily";
        configs = {
          "rootfs" = enable // {
            SUBVOLUME = "/";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 0;
            TIMELINE_LIMIT_WEEKLY = 2;
            TIMELINE_LIMIT_MONTHLY = 1;
          };
          "data" = enable // {
            SUBVOLUME = "/home";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 24;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_WEEKLY = 4;
            TIMELINE_LIMIT_MONTHLY = 3;
          };
          "config" = enable // {
            SUBVOLUME = "/var/lib";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_WEEKLY = 4;
            TIMELINE_LIMIT_MONTHLY = 2;
          };
          "cache" = enable // {
            SUBVOLUME = "/var/cache";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_WEEKLY = 4;
            TIMELINE_LIMIT_MONTHLY = 2;
          };
          "log" = enable // {
            SUBVOLUME = "/var/log";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_WEEKLY = 4;
            TIMELINE_LIMIT_MONTHLY = 2;
          };
        };
      };
  };
}
