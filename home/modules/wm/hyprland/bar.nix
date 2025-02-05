{ config, lib, pkgs, ... }:
{
	options = {
		bar.battery.enable = lib.mkOption {
			default = false;
			description = "enable battery module";
			type = lib.types.bool;
		};
	};

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
					modules-right = if config.bar.battery.enable then [ "pulseaudio" "tray" "battery" "clock" ]	else [ "pulseaudio" "tray" "clock" ];

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
