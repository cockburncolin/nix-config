# template for hosts
{ ... }:
{
	imports = [ 
		../../modules/bundle.nix
		./hardware-config.nix
	];

	config = {};
}
