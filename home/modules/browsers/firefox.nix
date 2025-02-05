{moduleBase ? "misc"}: {
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  moduleName = "firefox";
in {
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
      profiles.default = {
        id = 0;
        isDefault = true;
        name = "default";
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.search.defaultenginename" = "Searx";
          "browser.search.order.1" = "Searx";
          "browser.toolbarbuttons.introduced.pocket-button" = false;
          "browser.toolbars.bookmarks.visibility" = "always";
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extenstions.pocket.enabled" = false;
          "general.autoScroll" = true;
          "media.eme.enabled" = true;
          "signon.autofillForms" = false;
        };

        bookmarks = [
          {
            name = "wikipedia";
            tags = ["wiki"];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "kernel.org";
            url = "https://www.kernel.org";
          }
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = ["wiki" "nix"];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
        search = {
          force = true;
          default = "Searx";
          order = ["Searx"];
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
              definedAliases = ["@np"];
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
              definedAliases = ["@hm"];
            };
            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://nixos.wiki/index.php?search={searchTerms}";
                }
              ];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
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
              definedAliases = ["@searx"];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
          };
        };
      };
    };
  };
}
