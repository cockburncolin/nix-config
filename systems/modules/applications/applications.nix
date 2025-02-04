{ ... }:
let
	moduleBase = "apps";
	argSet = { "moduleBase" = moduleBase; };
in 
{
	imports = [ 
		(import ./systemApps.nix argSet)
		(import ./pkgConf.nix argSet)
		(import ./sound.nix argSet)
		./displayManagers/displayManagers.nix
		./windowManagers/windowManagers.nix
	];
}

