{ config, pkgs, inputs, ... }:
{
	imports = [
		./base.nix
		./fonts.nix
	];

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	programs = { 

		neovim = {
		  enable = true;
		  defaultEditor = true;
	  };
	};
	environment.systemPackages = with pkgs; [
		firefox
		mpv
		yt-dlp
	];
}
