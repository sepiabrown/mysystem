{ pkgs, inputs, ... }:
let

  mypackages = inputs.self.packages.${pkgs.system};

  inherit (mypackages)
    noto-sans-kr
    seoul-hangan
    mynerdfonts
  ;

in
{

  home.packages = with pkgs; [
    noto-sans-kr
    # noto-serif-kr
    # nerdfonts
    symbola
    seoul-hangan
    mynerdfonts
    noto-fonts-cjk
    # noto-fonts
    material-design-icons
    weather-icons
    font-awesome
    emacs-all-the-icons-fonts
  ];

}
