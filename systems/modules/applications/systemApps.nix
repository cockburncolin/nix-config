# Takes moduleBase from importing file
{
  moduleBase ? "misc",
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "systemApps";
in
{
  imports = [ ];

	config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
		programs.neovim = {
			enable = true;
			vimAlias = true;
			viAlias = true;
		};
		environment.systemPackages = with pkgs; [
			efibootmgr
			git
			nano
			tree
			wget
		];

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    environment.systemPackages = with pkgs; [
      efibootmgr
      git
      wget
      nano
    ];

  };
}
