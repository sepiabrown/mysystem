{ pkgs, inputs, ... }:
let

  mypackages = inputs.self.packages.${pkgs.system};

in
{

  home.packages = with pkgs; [
    nerdfonts
    symbola
    noto-fonts-cjk
    material-design-icons
    weather-icons
    font-awesome
    emacs-all-the-icons-fonts
  ] ++ (with mypackages;
  [ noto-sans-kr
    seoul-hangan
  ]);

}
