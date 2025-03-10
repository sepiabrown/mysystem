{ pkgs, nixosConfigurations, homeConfigurations }:
let
  inherit (builtins)
    flip
  ;

  inherit (pkgs)
    lib
    writeScriptBin
  ;

  mylib = import ../lib pkgs;

  inherit (mylib) get-user-hostname;

  text-to-app = name: text:
    let script = writeScriptBin "${name}.sh" ''
        ${text}
      '';
    in { type = "app"; program = "${script}/bin/${name}.sh"; };


  hosts = import ../nixosConfigurations/host-ips.nix;

in
{

  deploy = {
    nixos = lib.flip __mapAttrs nixosConfigurations (name: nixos:
      let
        host = hosts."${name}";
        toplevel = nixos.config.system.build.toplevel;
        profile = "/nix/var/nix/profiles/system";
      in
      text-to-app "deploy-${name}" ''
        nix copy ${toplevel} --to ssh://${host}
        ssh ${host} sudo nix-env --profile ${profile} --set ${toplevel}
        ssh ${host} sudo ${profile}/bin/switch-to-configuration switch
      ''
    );

    home = lib.flip __mapAttrs homeConfigurations (name: home:
      let
        inherit (get-user-hostname name) user hostname;
        host = "${user}@${hosts."${hostname}"}";
        script = home.activationPackage;
      in
      text-to-app "deploy-${name}" ''
        nix copy ${script} --to ssh://${host}
        ssh ${host} ${script}/bin/home-manager-generation
      ''
    );
  };

}
