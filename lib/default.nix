pkgs:
let

  inherit (pkgs.lib)
    makeExtensible
    splitString
    elemAt
  ;

  mylib = makeExtensible (self: let
    callLibs = file: import file pkgs self;
  in {

    get-toplevel = nixos: nixos.config.system.build.toplevel;
    get-isoimage = nixos: nixos.config.system.build.isoImage;

    get-boot-essential = nixosConfiguration:
      let inherit (nixosConfiguration.config.system) build;
      in {
        kernel = "${build.toplevel}/kernel";
        initrd = "${build.netbootRamdisk or build.toplevel}/initrd";
        cmdLine = "init=${build.toplevel}/init";
      };

    snippets = callLibs ./snippets.nix;


    get-user-hostname = str: let
      list = splitString "@" str;
    in {
      user = elemAt list 0;
      hostname = elemAt list 1;
    };

  });

in mylib
