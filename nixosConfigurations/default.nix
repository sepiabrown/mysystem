inputs:
let

  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = { inherit inputs; };

in
{
  urubamba = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/urubamba ];
  };

  lima = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/lima ];
  };

  lapaz = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/lapaz ];
  };

  bogota = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/bogota ];
  };

  antofagasta = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/antofagasta ];
  };

  giron = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/giron ];
  };

  # iguazu is for a USB installer
  iguazu = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/iguazu ];
  };

  garganta = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/garganta ];
  };

  usb = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/usb ];
  };

  havana = nixosSystem {
    inherit specialArgs;
    modules = [ ./hosts/havana ];
  };
}
