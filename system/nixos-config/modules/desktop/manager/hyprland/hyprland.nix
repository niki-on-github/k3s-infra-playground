{ config, lib, pkgs, inputs, nixpkgs-unstable, ... }:

{
  home.file = {
    ".config/hypr/hyprland.conf".text = ''
      monitor=Virtual-1,1920x1080@60,0x0,1
      #monitor=HDMI-A-3,1920x1080@60,1920x0,1
      #monitor=HDMI-A-1,1280x1028@60,3840x0,1

      workspace=Virtual-1
      #workspace=DP-1,0
      #workspace=HDMI-A-1,3

      wsbind=1,Virtual-1
      wsbind=2,Virtual-1
      wsbind=3,Virtual-1
      wsbind=4,Virtual-1
      wsbind=5,Virtual-1
      wsbind=6,Virtual-1
      wsbind=7,Virtual-1
      wsbind=8,Virtual-1
      wsbind=9,Virtual-1

      general {
        sensitivity=1
        main_mod=SUPER
        border_size=3
        gaps_in=5
        gaps_out=7
        col.active_border=0x80ffffff
        col.inactive_border=0x66333333
        layout=dwindle
      }

      decoration {
        rounding=5
        multisample_edges=true
        active_opacity=0.93
        inactive_opacity=0.93
        fullscreen_opacity=1
        blur=true
        drop_shadow=false
      }

      animations {
        enabled=true
        bezier = myBezier,0.1,0.7,0.1,1.05
        animation=fade,1,7,default
        animation=windows,1,7,myBezier
        animation=windowsOut,1,3,default,popin 60%
        animation=windowsMove,1,7,myBezier
      }

      input {
        kb_layout=us
        follow_mouse=2
        repeat_delay=250
        numlock_by_default=1
        force_no_accel=1
        sensitivity=1
      }

      dwindle {
        pseudotile=false
        force_split=2
      }

      debug {
        damage_tracking=2
      }

      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      bind=SUPER,Return,exec,${pkgs.alacritty}/bin/alacritty
      bind=SUPER,Q,killactive,
      bind=SUPER,Escape,exit,
      bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
      bind=SUPER,H,togglefloating,
      bind=SUPER,Space,exec,${pkgs.rofi}/bin/rofi -show drun
      bind=SUPER,P,pseudo,
      bind=SUPER,F,fullscreen,
      bind=SUPER,R,forcerendererreload
      #bind=SUPERSHIFT,R,exec,&pkgs.hyprland&/bin/hyprctl reload # TODO make var

      bind=SUPER,left,movefocus,l
      bind=SUPER,right,movefocus,r
      bind=SUPER,up,movefocus,u
      bind=SUPER,down,movefocus,d

      bind=SUPERSHIFT,left,movewindow,l
      bind=SUPERSHIFT,right,movewindow,r
      bind=SUPERSHIFT,up,movewindow,u
      bind=SUPERSHIFT,down,movewindow,d

      bind=ALT,1,workspace,1
      bind=ALT,2,workspace,2
      bind=ALT,3,workspace,3
      bind=ALT,4,workspace,4
      bind=ALT,5,workspace,5
      bind=ALT,6,workspace,6
      bind=ALT,7,workspace,7
      bind=ALT,8,workspace,8
      bind=ALT,9,workspace,9
      bind=ALT,0,workspace,10
      bind=ALT,right,workspace,+1
      bind=ALT,left,workspace,-1

      bind=ALTSHIFT,1,movetoworkspace,1
      bind=ALTSHIFT,2,movetoworkspace,2
      bind=ALTSHIFT,3,movetoworkspace,3
      bind=ALTSHIFT,4,movetoworkspace,4
      bind=ALTSHIFT,5,movetoworkspace,5
      bind=ALTSHIFT,6,movetoworkspace,6
      bind=ALTSHIFT,7,movetoworkspace,7
      bind=ALTSHIFT,8,movetoworkspace,8
      bind=ALTSHIFT,9,movetoworkspace,9
      bind=ALTSHIFT,0,movetoworkspace,10
      bind=ALTSHIFT,right,movetoworkspace,+1
      bind=ALTSHIFT,left,movetoworkspace,-1

      bind=CTRL,right,resizeactive,20 0
      bind=CTRL,left,resizeactive,-20 0
      bind=CTRL,up,resizeactive,0 -20
      bind=CTRL,down,resizeactive,0 20

      bind=,print,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png"

      bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10
      bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10
      bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
      bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t
      bind=,XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 5
      bind=,XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 5

      windowrule=float,^(Rofi)$
      windowrule=float,title:^(Picture-in-Picture)$
      windowrule=float,title:^(Volume Control)$

      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      #exec-once=${pkgs.swaybg}/bin/swaybg -m center -i $HOME/.config/wall
      exec-once=${nixpkgs-unstable.mpvpaper}/bin/mpvpaper -sf -v -o "--loop --panscan=1" '*' $HOME/.config/wall.mp4
      exec-once=${pkgs.waybar}/bin/waybar
      exec-once=${pkgs.blueman}/bin/blueman-applet
    '';
  };
}
