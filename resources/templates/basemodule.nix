{ ... }:
let
	baseModule = "";
	argSet = { "baseModule" = baseModule; };
in 
{
	imports = [ 
		(import ./submodule.nix argSet)
	];
}

