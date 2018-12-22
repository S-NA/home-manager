{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    services.keynav = {
      enable = mkEnableOption "Keynav Daemon";
    };
  };

  config = mkIf config.services.keynav.enable {
    systemd.user.services.keynav = {
      Unit = {
        Description = "Drive the pointer with the keyboard";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
  
      Service = {
        Type = "simple";
        Environment = "PATH=%h/.nix-profile/bin";
        ExecStart = "${pkgs.keynav}/bin/keynav";
      };
  
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
