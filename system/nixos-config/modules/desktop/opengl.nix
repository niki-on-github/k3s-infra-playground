{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;

    # Enable accelerated OpenGL rendering through the Direct
    # Rendering Interface (DRI)
    driSupport = true;

    # Support Direct Rendering for 32-bit applications (such
    # as Wine). This is currently only supported for the
    # nvidia and ati_unfree drivers, as well as Mesa
    driSupport32Bit = true;

    # Use Mesa OpenGL drivers
    package = pkgs.mesa_drivers;
  };
}
