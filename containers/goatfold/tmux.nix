{ ... }:
# Minecraft servers are not really daemons, so we need to interact with them.
{
  programs.tmux = {
    enable = true;
    # So server keeps running with we ssh out
    secureSocket = false;
    clock24 = true;
  };
}
