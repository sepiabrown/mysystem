{ name ? "wavetojj", ... }@all: let

  address = "${name}@gmail.com";

in {

  accounts.email.accounts.${name} = {
    inherit address;
    realName = "JJ Kim";
    passwordCommand = "pass email/${address}";
    msmtp.enable = true;
    notmuch.enable = true;
    flavor = "gmail.com";
    signature = {
      text = ''
        JJ Kim
      '';
      showSignature = "append";
    };
  } // (removeAttrs all ["name"]);

  programs.mbsync.extraConfig = ''
    IMAPAccount ${name}
    Host imap.gmail.com
    User ${address}
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
    Far :${name}-remote:"[Gmail]/Sent Mail"
    Near :${name}-local:sent

    Channel ${name}-drafts
    Far :${name}-remote:"[Gmail]/Drafts"
    Near :${name}-local:drafts

    Channel ${name}-archive
    Far :${name}-remote:"[Gmail]/All Mail"
    Near :${name}-local:archive

    Channel ${name}-junk
    Far :${name}-remote:"[Gmail]/Spam"
    Near :${name}-local:junk

    Channel ${name}-trash
    Far :${name}-remote:"[Gmail]/Trash"
    Near :${name}-local:trash

    Group ${name}
    Channel ${name}-inbox
    Channel ${name}-sent
    Channel ${name}-drafts
    Channel ${name}-archive
    Channel ${name}-junk
    Channel ${name}-trash
  '';

}
