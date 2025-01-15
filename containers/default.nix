{ pkgs, ... }:
# Containers entrypoint
{
  # Define containers
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      Goatfold = {
        hostname = "Goatfold";
        serviceName = "container-Goatfold";
        workdir = "/containers/Goatfold";
      };
    };
  };

  # Podman config
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    dockerSocket.enable = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Just install these vm descriptors
  environment.etc = {
    "guests/goatfold.cfg".text = ''
      name = 'Goatfold'
      type = 'hvm'
      device_model_version = 'qemu-xen'
      device_model_override = '${pkgs.qemu_xen}/bin/qemu-system-i386'
      boot = 'c'
      memory = '8192'
      vcpus = 4
      vif = [ 'mac=2e:90:d6:0b:ee:d9,bridge=xenbr0' ]
      disk = [ '/xen/images/goatfold.qcow2,qcow2,hda,w' ]
    '';
  };
}
