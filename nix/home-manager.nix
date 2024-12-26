{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.git-town;
  aliasableCommands = [
    "append"
    "compress"
    "contribute"
    "diff-parent"
    "hack"
    "delete"
    "observe"
    "park"
    "prepend"
    "propose"
    "rename"
    "repo"
    "set-parent"
    "ship"
    "sync"
  ];
in
{
  options.programs.git-town = {
    enable = lib.mkEnableOption "Enable git-town";
    package = lib.mkPackageOption pkgs "git-town" { };
    enableAllAliases = lib.mkEnableOption {
      default = false;
      description = ''
        Enable all git-town aliases. This will add all git-town aliases to your
        global git configuration.
      '';
    };
    aliases = lib.mkOption {
      default = [ ];
      description = ''
        List of git-town aliases to be added to your global git configuration.
      '';
      type = lib.types.listOf (lib.types.enum aliasableCommands);
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    programs.git.aliases = lib.attrsets.genAttrs (
      if cfg.enableAllAliases then aliasableCommands else cfg.aliases
    ) (alias: "town " + alias);
    assertions = [
      {
        assertion = (!cfg.enableAllAliases) || (cfg.aliases == [ ]);
        message = ''
          Enabling specific aliases is not allowed when enableAllAliases is true.
        '';
      }
      {
        assertion = config.programs.git.enable;
        message = ''
          git-town requires git to be enabled. If you just want to install git-town,
          you can just add it to home.packages.
        '';
      }
    ];
  };
}
