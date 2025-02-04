# Takes the baseModule param from importing file
{ moduleBase ? "misc" }: # set default as misc to avoid beaking things if not declared
{ config, lib, pkgs, ... }:
let
	moduleName = "baseSystem";
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
		security.pam.services.hyprlock =  {};

		nix = {
			settings.experimental-features = [ "nix-command" "flakes" ];
			
			gc = {
				automatic = true;
				dates = "weekly";
				options = "--delete-older-than 15d";
			};
		};
	};
}	
