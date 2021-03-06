{ config, pkgs, libs, ... }:
{
  accounts.email = {
    maildirBasePath = "/home/scott/.mail";
    accounts = {
      Gmail = {
        address = "scottwalls2008@gmail.com";
        userName = "scottwalls2008@gmail.com";
        flavor = "gmail.com";
        passwordCommand = "${pkgs.pass}/bin/pass scottwalls2008@gmail.com";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" "[Gmail]*" ]; # "[Gmail]/Sent Mail" ];
        };
        realName = "scott";
        msmtp.enable = true;
      };
    };
  };

  home.packages = with pkgs; [ mu isync ];

  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
  };
}
