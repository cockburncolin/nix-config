{
  moduleBase ? "misc",
}:
{
  config,
  inputs,
  pkgs,
  lib,
  firefox-adds,
  ...
}:
let
  moduleName = "firefox";
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
    programs.firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        PasswordManagerEnabled = false;
        DisablePocket = true;
        DisplayBookmarksToolbar = "always";
        NoDefaultBookmarks = true;
        OverrideFirstRunPage = "";
        OfferToSaveLogins = false;
        HttpsOnlyMode = "enabled";

        UserMessaging = {
          UrlbarInterventions = false;
          SkipOnboarding = true;
        };

        FirefoxHome = {
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponseredPocket = false;
          Snippets = false;
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
          };
          VirtualReality = {
            BlockNewRequests = true;
          };
        };
        Preferences = {
          "browser.urlbar.suggest.searches" = true; # Need this for basic search suggestions
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.shortcuts.tabs" = false;

          "browser.tabs.tabMinWidth" = 75; # Make tabs able to be smaller to prevent scrolling

          "browser.aboutConfig.showWarning" = false; # No warning when going to config
          "browser.warnOnQuitShortcut" = false;

          "browser.tabs.loadInBackground" = true; # Load tabs automatically

          "media.ffmpeg.vaapi.enabled" = true; # Enable hardware acceleration
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;

          "extensions.autoDisableScopes" = 0; # Automatically enable extensions
          "extensions.update.enabled" = false;

          "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
        };
      };
      profiles.default = {
        id = 0;
        isDefault = true;
        name = "default";
        extensions = with firefox-adds; [
          bitwarden
          darkreader
          privacy-badger
          ublock-origin
          youtube-shorts-block
        ];
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.search.defaultenginename" = "Searx";
          "browser.search.order.1" = "Searx";
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.toolbarbuttons.introduced.pocket-button" = false;
          "browser.toolbars.bookmarks.visibility" = "always";
          "extensions.autoDisableScopes" = 0;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.pocket.enabled" = false;
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.transition.timeout" = "0";
          "full-screen-api.warning.delay" = "0";
          "full-screen-api.warning.timeout" = "0";
          "general.autoScroll" = true;
          "media.eme.enabled" = true;
          "signon.autofillForms" = false;
          "toolkit.cosmeticAnimations.enabled" = false;
        };
        bookmarks = [
          {
            #Toolbar Folder
            name = "toolbar";
            toolbar = true;
            bookmarks = [
              {
                # Folder in the Toolbar
                name = "Stores";
                bookmarks = [
                  {
                    name = "Amazon";
                    url = "https://amazon.ca";
                    keyword = "";
                  }
                ];
              }
              {
                name = "Torrents";
                bookmarks = [
                  {
                    name = "TorrentLeech";
                    url = "https://torrentleech.org";
                  }
                ];
              }
            ];
          }
        ];
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
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
          };
        };
      };
    };
  };
}
