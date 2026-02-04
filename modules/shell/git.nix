{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = false;
    settings = {
      user = {
        name = "Scott Walls";
        email = "scottwalls2008@gmail.com";
      };
      url = {
        "git://github.com/" = {
          insteadOf = "github:";
        };
        "git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = [ "github:" "git://github.com/" ];
        };
      };
    };
    # signing = {
    #   key = "03F336CD4EE53555";
    #   signByDefault = true;
    # };
    ignores = [
      "*.o"
    ];
  };
}
