{ runCommand, nerdfonts }:
let

  mkFont = path: runCommand "myfont" {} ''
    target=$out/share/fonts/myfont
    mkdir -p $target
    cp ${path}/*.ttf ${path}/*.otf $target
  '';

in {

  myfonts = runCommand "myfonts" {} ''
    install -m444 -Dt $out/share/fonts/myfonts ${./fonts}/*/*.ttf
    install -m444 -Dt $out/share/fonts/myfonts ${./fonts}/*/*.otf
  '';

  cute-font      = mkFont ./fonts/Cute_Font;
  hi-melody      = mkFont ./fonts/Hi_Melody;
  kirang-haerang = mkFont ./fonts/Kirang_Haerang;
  nanum-gothic   = mkFont ./fonts/Nanum_Gothic;
  nanum-myeongjo = mkFont ./fonts/Nanum_Myeongjo;
  noto-sans-kr   = mkFont ./fonts/Noto_Sans_KR;
  noto-serif-kr  = mkFont ./fonts/Noto_Serif_KR;
  seoul-hangan   = mkFont ./fonts/Seoul_Hangan;
  single-day     = mkFont ./fonts/Single_Day;
  sunflower      = mkFont ./fonts/Sunflower;
  yeon-sung      = mkFont ./fonts/Yeon_Sung;

}
