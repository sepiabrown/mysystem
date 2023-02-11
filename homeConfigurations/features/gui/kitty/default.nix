{

  programs.kitty = {
    enable = true;
    extraConfig = ''

      font_family      Mononoki Nerd Font
      bold_font        auto
      italic_font      auto
      bold_italic_font auto

      font_size 10.0
      background_opacity 0.95
      dynamic_background_opacity yes
      window_padding_width 2
      hide_window_decorations yes

      window_border_width 0.0px
      active_border_color #FF2c34
      inactive_border_color #282cFF

      include ${./theme/tomorrow-night}
    '';

  };

}
