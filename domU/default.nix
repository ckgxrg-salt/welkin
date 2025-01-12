{ ... }:
# Xen entrypoint
{
  # Just install these vm descriptors
  environment.etc = {
    "xen-vms/goatfold.cfg".source = ./goatfold/goatfold.cfg;
  };
}
