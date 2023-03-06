{ pkgs, ... }:

{

  home.packages = with pkgs; [

    evince
    apvlv
    mupdf
    qpdfview
    okular
    pdfarranger

  ];
}
