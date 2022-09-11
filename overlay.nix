inputs: final: prev: with final;
{

  screenlayout = callPackage ./packages/scripts/screenlayout {};
  restart-xmonad = callPackage ./packages/scripts/restart-xmonad {};
  mysetxkbmap = callPackage ./packages/scripts/mysetxkbmap {};
  dmenu-scripts = callPackage ./packages/scripts/dmenu-scripts {};
  dracula-qutebrowser = callPackage ./packages/dracula-qutebrowser {};
  mychemacs2 = callPackage ./packages/mychemacs2 {  inherit inputs; };

  # linuxPackages = prev.linuxPackages.extend (self: super: {
  #   rtw89 = self.callPackage ./packages/rtw89 {};
  # });
  # linuxPackages_latest = prev.linuxPackages_latest.extend (self: super: {
  #   rtw89 = self.callPackage ./packages/rtw89 {};
  # });
  # rtw89-firmware = callPackage ./packages/rtw89-firmware {};

  mytex = texlive.combine {
    inherit (texlive)
      collection-basic
      collection-bibtexextra
      collection-latex
      collection-latexextra
      collection-latexrecommended
      collection-binextra
      collection-langenglish
      collection-langkorean
      collection-langcjk
      collection-plaingeneric
      collection-fontutils
      collection-fontsextra
      collection-fontsrecommended
      collection-context
      collection-metapost
      collection-texworks
      collection-luatex
      collection-xetex
      collection-pictures
      collection-pstricks
      collection-publishers
      collection-mathscience
    ;

  };


  mk-deploy-sh = host: store: let
    profile = "/nix/var/nix/profiles/system";
  in writeShellScriptBin "deploy-sh" ''
    host="${host}"
    store="${store}"
    nix-copy-closure --to $host $store
    ssh $host sudo nix-env --profile ${profile} --set $store
    ssh $host sudo ${profile}/bin/switch-to-configuration switch
  '';

  deploy-sh = mk-deploy-sh "$1" "$2";

  # nixOSApps = (pkgs.lib.mapAttrs
  #   (name: host: let
  #     nixOSConf = mkNixOSConfiguration name host;
  #     nixOSPkg = nixOSConf.config.system.build.toplevel;
  #   in
  #   {
  #     type = "app";
  #     program = "${mk-deploy-sh host.ip nixOSPkg}/bin/deploy-sh";
  #   })
  #   hosts);

}
