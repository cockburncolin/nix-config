{
  moduleBase ? "misc",
}:
{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  moduleName = "librewolf";
in
{
  options = {
    "${moduleBase}"."${moduleName}" = {
      enable = lib.mkOption {
        default = true;
        description = "manage ${moduleName}";
      };
    };
  };

  config = lib.mkIf config."${moduleBase}"."${moduleName}".enable {
    programs.librewolf = {
      enable = true;
      policies = {
        ExtensionSettings = {
          "*".installation_mode = "blocked";
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };

          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };

          "@testpilot-containers" = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/multi-account-containers/latest.xpi";
            installation_mode = "force_installed";
          };

          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };

          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };

          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
            installation_mode = "force_installed";
          };

          "{34daeb50-c2d2-4f14-886a-7160b24d66a4}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-shorts-block/latest.xpi";
            installation_mode = "force_installed";
          };

          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        Permissions = {
          Location = {
            BlockNewRequests = true;
            Allow = [ "https://www.playnow.com/" ];
          };
          Microphone = {
            BlockNewRequests = true;
            Allow = [
              "https://teams.microsoft.com/"
              "https://zoom.com"
            ];
          };
          Notifications = {
            BlockNewRequests = true;
          };
          Camera = {
            BlockNewRequests = true;
            Allow = [
              "https://teams.microsoft.com/"
              "https://zoom.com"
            ];
          };
          VirtualReality = {
            BlockNewRequests = true;
          };
        };
      };
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "network.http.referer.XOriginPolicy" = 2;
        "privacy.resistFingerprinting.letterboxing" = true;
        "media.eme.enabled" = true;
        "signon.autofillForms" = false;
        "toolkit.cosmeticAnimations.enabled" = false;
      };

      profiles.default = {
        id = 0;
        isDefault = true;
        name = "default";
        search = {
          force = true;
          default = "Searx";
          order = [ "Searx" ];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "release";
                      value = "master";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@hm" ];
            };
            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://nixos.wiki/index.php?search={searchTerms}";
                }
              ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "Searx" = {
              urls = [
                {
                  template = "https://searx.colincockburn.xyz/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/b/b7/SearXNG-wordmark.svg";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@searx" ];
            };
            "Melpa" = {
              urls = [
                {
                  template = "https://melpa.org/#/";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "@mp"
                "@melpa"
              ];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
          };
        };
      };
    };
  };
}
