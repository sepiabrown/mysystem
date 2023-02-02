{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 604800; #== 7 days in seconds
    enableSshSupport = true;
  };
}
