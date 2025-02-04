{ ... }:
let
	moduleBase = "apps.windowManagers";
	argSet = { "moduleBase" = moduleBase; };
in 
{
	imports = [ 
		(import ./hyprland.nix argSet)
	];
}

