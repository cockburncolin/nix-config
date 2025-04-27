{ pkgs }:
{
  kubero-cli = import ../packages/server/kubero-cli { inherit pkgs; };
}
