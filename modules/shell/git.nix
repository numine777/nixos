{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Scott Walls";
    userEmail = "scottwalls2008@gmail.com";
    # signing = {
    #   key = "03F336CD4EE53555";
    #   signByDefault = true;
    # };
    ignores = [
      "*.o"
    ];
    extraConfig = {
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      diff = {
        tool = "difftastic";
      };
      difftool = {
        prompt = false;
      };
      difftool."difftastic" = {
        cmd = ''difft "$MERGED" "$LOCAL" "abcdef1" "100644" "$REMOTE" "abcdef2" "100644"'';
      };
      pager = {
        difftool = true;
      };
      delta = {
        navigate = true;
        dark = true;
      };
      merge = {
        conflictStyle = "diff3";
      };
      merge."mergiraf" = {
        name = "mergiraf";
        driver = "mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P -l %L";
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
  };
}
