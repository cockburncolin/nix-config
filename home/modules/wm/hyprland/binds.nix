{
  config,
  lib,
  ...
}:
let
  editor = "emacsclient -a nvim -c";
  menu = "anyrun";
  term = "kitty";
in
{
  config = {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

      binde = [
        # resize windows
        "$mod+Alt, Right, resizeactive, 30 0"
        "$mod+Alt, Left, resizeactive, -30 0"
        "$mod+Alt, Up, resizeactive, 0 -30"
        "$mod+Alt, Down, resizeactive, 0 30"

        # audio control
        ", XF86AudioLowerVolume, exec, pactl get-default-sink | xargs -I def-sink pactl set-sink-volume def-sink -5%"
        ", XF86AudioRaiseVolume, exec, pactl get-default-sink | xargs -I def-sink pactl set-sink-volume def-sink +5%"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        [
          # applications
          "$mod+shift, RETURN, exec, ${term}"
          "$mod, E, exec, ${editor}"
          "$mod, SPACE, exec, ${menu}"

          # audio control
          ", XF86AudioMute, exec, pactl get-default-sink | xargs -I def-sink pactl set-sink-mute def-sink toggle"
          ", XF86AudioMicMute, exec, pactl get-default-source | xargs -I def-sink pactl set-source-mute def-sink toggle"

          # move/change window focus
          "$mod, Left, movefocus, l"
          "$mod, Right, movefocus, r"
          "$mod, Up, movefocus, u"
          "$mod, Down, movefocus, d"
          "Alt, Tab, movefocus, d"
          "$mod, RETURN, layoutmsg, swapwithmaster master"
          "$mod+Shift, Left, layoutmsg, swapprev noloop"
          "$mod+Shift, Right, layoutmsg, swapnext noloop"

          "$mod, C,  killactive"
          "$mod, M,  fullscreen, 1"
          "$mod, T,  togglefloating, "

          # misc
          ## Disable gaps
          "$mod, G, exec, hyprctl keyword general:gaps_in 0 && hyprctl keyword general:gaps_out 0"
          "$mod, R, exec, hyprctl reload"

          ## hyprshade
          "$mod, F1, exec, hyprshade toggle blue-light-filter"
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
