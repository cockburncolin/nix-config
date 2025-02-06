let
  moduleBase = "editors";
  argSet = {
    "moduleBase" = moduleBase;
  };
in
{
  imports = [
    (import ./obsidian.nix argSet)
    (import ./vscode.nix argSet)
  ];
}
