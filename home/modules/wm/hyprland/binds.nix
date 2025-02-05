{
  config,
  lib,
  ...
}:
let
  term = "kitty";
  menu = "wofi --show drun";
  browser = "firefox";
in
{
  config = {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

      bind =
        [
          # applications
          "$mod, F, exec, ${browser}"
          "$mod+shift, RETURN, exec, ${term}"

          # audio control
          # ", F10, exec, $scrPath/volumecontrol.sh -o m"
          # ", F11, exec, $scrPath/volumecontrol.sh -o d"
          # ", F12, exec, $scrPath/volumecontrol.sh -o i"
          # ", XF86AudioMute, exec, $scrPath/volumecontrol.sh -o m"
          # ", XF86AudioMicMute, exec, $scrPath/volumecontrol.sh -i m"
          # ", XF86AudioLowerVolume, exec, $scrPath/volumecontrol.sh -o d"
          # ", XF86AudioRaiseVolume, exec, $scrPath/volumecontrol.sh -o i"

          # move/change window focus
          "$mod, Left, movefocus, l"
          "$mod, Right, movefocus, r"
          "$mod, Up, movefocus, u"
          "$mod, Down, movefocus, d"
          "Alt, Tab, movefocus, d"
          "$mod, RETURN, layoutmsg, swapwithmaster master"
          "$mod+Shift, Left, layoutmsg, swapprev noloop"
          "$mod+Shift, Right, layoutmsg, swapnext noloop"

          # resize windows
          "$mod+Alt, Right, resizeactive, 30 0"
          "$mod+Alt, Left, resizeactive, -30 0"
          "$mod+Alt, Up, resizeactive, 0 -30"
          "$mod+Alt, Down, resizeactive, 0 30"

          "$mod, C,  killactive"
          "$mod, M,  fullscreen, 1"
          "$mod, T,  togglefloating, "

          # misc
          ## Disable gaps
          "$mod, G, exec, hyprctl keyword general:gaps_in 0 && hyprctl keyword general:gaps_out 0"
          "$mod, R, exec, hyprctl reload"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
    };
  };
}
