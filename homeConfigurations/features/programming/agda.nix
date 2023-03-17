{ pkgs, ... }:

{

  home.packages = with pkgs; [
    (agda.withPackages (ps : with ps; [ standard-library ]))
  ];


}
