{ config, lib, pkgs, ... }:
{
	config = {
		programs.waybar = {
			enable = true;
			systemd.enable = true;
			settings = {
				mainBar = {
					layer = "top";
					position = "top";
					height = 30;
					modules-left = [ "hyprland/workspaces" ];
					modules-right = [ "pulseaudio" "tray" "clock" ];

					# module config
					clock = {
						format = "{:%a %b %d %Y - %R %Z}";
					};

					pulseaudio = {
						format = "{desc} {volume}%";
						on-click = "pavucontrol";
					};
					
					tray = {
						spacing = 10;
					};
				};

			};
		};
	};
}
