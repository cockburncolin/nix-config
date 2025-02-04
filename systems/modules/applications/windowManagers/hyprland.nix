# Takes moduleBase from importing file
{ moduleBase ? "misc" }:
{ config, lib, pkgs, ... }:
let
	moduleName = "hyprland";
in
{
	imports = [  ];
	
	options = {
		"${moduleBase}"."${moduleName}" = {
			enable = lib.mkOption {
				default = true;
				description = "enable ${moduleName}";
				type = lib.types.bool;
			};
		};
	};

	config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
		programs.hyprland.enable = true;

		environment = {
			# default hyprland config uses kitty, download it in case bootable but something don't work
			systemPackages = [ pkgs.kitty ];

			sessionVariables.NIXOS_OZONE_WL = "1";
		};
	};
}	
