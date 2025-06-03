{ ... }:
{
  # Login Messages
  environment.etc = {
    "motd".text = ''
      Heart of the Internet of Fundamentals
    '';
    "issue".text = ''
      You are not welcomed generally.
    '';
  };

  users = {
    users = {
      # System administration & maintance
      "elekiana" = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [ "wheel" ];
        description = "Mysterious technician";
        openssh.authorizedKeys.keyFiles = [
          ../keys/daywatch-ssh.pub
          ../keys/rhyslow-ssh.pub
        ];
      };
      root = {
        openssh.authorizedKeys.keyFiles = [
          ../keys/daywatch-ssh.pub
          ../keys/rhyslow-ssh.pub
        ];
      };
    };
  };
}
