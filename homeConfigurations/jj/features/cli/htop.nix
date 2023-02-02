{
  programs.htop = {
    enable = true;
    settings = {
      sortDescending = true;
      sortKey = "PERCENT_CPU";
    };
  };
}
