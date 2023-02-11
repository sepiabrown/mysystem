{

  users.extraUsers.jiwon = {
    isNormalUser = true;
    home = "/home/jiwon";
    extraGroups = [ "wheel" "networkmanager" "input" "uinput" "data" ];
    hashedPassword = "$6$TDbJCKCsILgYa5dj$TRdwRPZbDDI23SquekrWy.vAKEfYRemFdRbRPY3PFQOi2y9q.ksJbGJNtRK.9RsZfkYJekyFnG2IUfdSS/45S/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXifjBn6gkBCKkpJJAbB1pJC1zSUljf8SFnPqvB6vIR jjdosa"
    ];
  };

}
