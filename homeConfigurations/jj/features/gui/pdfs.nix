{ pkgs, ... }:

{

  home.packages = with pkgs; [

    foxitreader
    evince
    apvlv
    mupdf
    qpdfview
    okular
    pdfarranger

  ];
}
