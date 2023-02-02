{

  programs.alacritty = {

    enable = true;

    settings =  {

      env = {
        "TERM" = "xterm-256color";
      };

      selection.save_to_clipboard = true;

      window = {
        padding.x = 10;
        padding.y = 10;
        decorations = "None";
        opacity = 0.95;
      };

      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };

      font = {
        size = 12.0;
        normal.family = "Mononoki Nerd Font";
        bold.family = "Mononoki Nerd Font";
        italic.family = "Mononoki Nerd Font";
      };

      cursor.style = "Beam";
      colors = import ./theme/tomorrow-night;

      # shell = {
      #   program = "${fish}/bin/fish";
      #   args = [
      #     "-C"
      #     "${neofetch}/bin/neofetch"
      #   ];
      # }

    };

  };

}
