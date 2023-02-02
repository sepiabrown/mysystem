{ pkgs, lib, ... }: let

  mkGmail = import ./mkGmail;
  mkDaum = import ./mkDaum;

in {

  # programs.mbsync.enable = true;
  programs.mbsync = {
    enable = true;
    extraConfig = lib.mkBefore ''
      Create Both
      Expunge Both
      SyncState *
      Sync All
    '';

  };
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
    hooks = {
      preNew = "mbsync --all";
    };
    new.ignore = [
      ".mbsyncstate"
      ".mbsyncstate.lock"
      ".mbsyncstate.new"
      ".mbsyncstate.journal"
      ".uidvalidity"
    ];
  };

  accounts.email.maildirBasePath = "Mail";

  imports = [
    (mkGmail { name = "wavetojj"; primary = true; })
    (mkDaum { name = "haedosa"; })
  ];


  home.file.".mailcap".text =
    if pkgs.stdenv.hostPlatform.isLinux
      then "text/html; xdg-open %s; nametemplate=%s.html"
      else "text/html; open %s; nametemplate=%s.html";

}
