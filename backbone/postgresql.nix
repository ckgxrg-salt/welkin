{ ... }:
{
  services.postgresql = {
    enable = true;
    initdbArgs = [
      "--no-locale"
    ];
  };
}
