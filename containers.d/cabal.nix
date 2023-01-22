{ config, pkgs, ... }: {

	containers.cabal = {
		autoStart = true;
		privateNetwork = true;
		bindMounts = {
			"/media" = {
				hostPath = "/media";
				isReadOnly = false;
			};
		};
		config = { config, pkgs, ... }: {
			system.stateVersion = "22.11";
			nixpkgs.config.allowUnfree = true;
			environment.systemPackages = [ pkgs.home-assistant ];
			services.home-assistant = {
				enable = true;
				config.text = ''
				{
					homeassistant = {
						name = "Der Lebensraum";
					};
				}
				'';
			};
		};
	};

	services.nginx.virtualHosts = {
		"prometheus.aetheric.co.nz" = {
			locations = {
				"/cabal" = {
				};
			};
		};
	};

}