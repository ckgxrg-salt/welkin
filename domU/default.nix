{ ... }:
# Xen entrypoint
{
  # Just install these vm descriptors
  environment.etc = {
    "guests/goatfold.cfg".source = ./goatfold/goatfold.cfg;
  };
}
