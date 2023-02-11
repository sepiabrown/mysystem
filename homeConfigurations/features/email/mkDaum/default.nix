{ name ? "haesoda", ... }@all: let

  address = "jj@haedosa.xyz";

in {

  accounts.email.accounts.${name} = {
    inherit address;
    realName = "JJ Kim";
    passwordCommand = "pass email/${address}";
    notmuch.enable = true;
    signature = {
      text = ''
        JJ Kim
        May the solution be with you!
      '';
      showSignature = "append";
    };
    mbsync.create = "maildir";

  } // (removeAttrs all ["name"]);

  programs.mbsync.extraConfig = ''
    IMAPAccount ${name}
    Host imap.daum.net
    User dontorzz
    Port 993
    PassCmd "pass email/${address}"
    SSLType IMAPS
    CertificateFile /etc/ssl/certs/ca-certificates.crt

    # Remote storage
    IMAPStore ${name}-remote
    Account ${name}

    # Local storage
    MaildirStore ${name}-local
    Path ~/Mail/${name}/
    Inbox ~/Mail/${name}/inbox

    Channel ${name}-inbox
    Far :${name}-remote:"INBOX"
    Near :${name}-local:inbox

    Channel ${name}-sent
    Far :${name}-remote:"Sent Messages"
    Near :${name}-local:sent

    Channel ${name}-drafts
    Far :${name}-remote:"Drafts"
    Near :${name}-local:drafts

    Channel ${name}-archive
    Far :${name}-remote:"All"
    Near :${name}-local:archive

    Channel ${name}-junk
    Far :${name}-remote:"&wqTTONO4ycDVaA-"
    Near :${name}-local:junk

    Channel ${name}-trash
    Far :${name}-remote:"Deleted Messages"
    Near :${name}-local:trash

    Group ${name}
    Channel ${name}-inbox
    Channel ${name}-sent
    Channel ${name}-drafts
    Channel ${name}-archive
    Channel ${name}-junk
    Channel ${name}-trash
  '';

  programs.msmtp.extraConfig = ''
    account haedosa
    auth on
    from jj@haedosa.xyz
    host smtp.daum.net
    port 465
    tls on
    tls_starttls off
    tls_trust_file /etc/ssl/certs/ca-certificates.crt
    user dontorzz
    passwordeval pass email/jj@haedosa.xyz
  '';

}
