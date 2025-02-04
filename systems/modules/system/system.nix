{ lib, inputs, ... }:
let
	moduleBase = "system";
	argSet = { "moduleBase" = moduleBase; };
in
{
	imports =  [
		(import ./baseSystem.nix argSet)
		(import ./boot.nix argSet)
		(import ./user.nix argSet)
	];
}
