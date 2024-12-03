{  pkgs, ... }:

{
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  systemd.services."fprintd".environment."G_MESSAGES_DEBUG" = "all"; # for good measure
}
