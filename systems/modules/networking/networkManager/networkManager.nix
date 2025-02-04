# Takes moduleBase from importing file
{ moduleBase ? "misc" }:
{ config, lib, pkgs, ... }:
let
	moduleName = "networkManager";
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
			# TODO make this add in connections
			createVPNConnections = lib.mkOption {
				default = true;
				description = "automatically create VPN connection profiles";
				type = lib.types.bool;
			};
		};
	};

	config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
		networking.networkmanager = {
			enable = true;
		};
	};
}	
