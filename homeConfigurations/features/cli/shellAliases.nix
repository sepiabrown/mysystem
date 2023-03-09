{
  home.shellAliases = {
    # ls   = "exa";
    du       = "ncdu --color dark";
    ls       = "ls --color=auto";
    "l."     = "ls -d .*";
    la       = "ls -a";
    ll       = "ls -l";
    lla      = "ls -al";
    ec       = "emacsclient";
    ecc      = "emacsclient -c";
    ping     = "prettyping";
    ".."      = "cd ..";
    "..."     = "cd ../..";
    "...."    = "cd ../../..";
    "....."   = "cd ../../../..";
    "......"  = "cd ../../../../..";
    "......." = "cd ../../../../../..";
    ".2"      = "cd ../..";
    ".3"      = "cd ../../..";
    ".4"      = "cd ../../../..";
    ".5"      = "cd ../../../../..";
    ".6"      = "cd ../../../../../..";
    p = "pushd";
    d = "dirs -v";
    o = "xdg-open";

    # taken from https://github.com/jhhuh/dot/blob/master/nixpkgs/home.nix
    nix-run = ''function __nix-run() { nix run "nixpkgs#$1" "''${@:2}"; }; __nix-run'';
    nix-repl = "nix repl '<nixpkgs>'";
    nix-which = "function __nix-which() { readlink $(which $1); }; __nix-which";
    nix-unpack-from = "function __nix-unpack-from() { nix-shell $1 -A $2 --run unpackPhase; }; __nix-unpack-from";
    nix-unpack = "nix-unpack-from '<nixpkgs>'";
    nix-where-from = "function __nix-where-from() { nix-build $1 -A $2 --no-out-link; }; __nix-where-from";
    nix-where = "nix-where-from '<nixpkgs>'";
    nix-show-tree = "function __nix-show-tree() { nix-shell -p tree --run 'tree $(nix-where $1)'; }; __nix-show-tree";
    nix-visit = "function __nix-visit() { pushd $(nix-where $1); }; __nix-visit";
    nix-X-help-in-Y = "function __nix-X-help-in-Y() { $(nix-where w3m)/bin/w3m $1/share/doc/$2; }; __nix-X-help-in-Y";
    nix-help = "nix-X-help-in-Y $(nix-where nix.doc) nix/manual/index.html";
    nixpkgs-help = "nix-X-help-in-Y $(nix-build --no-out-link '<nixpkgs/doc>') nixpkgs/manual.html";
    nixos-help = "nix-X-help-in-Y $(nix-build '<nixpkgs/nixos/release.nix>' --arg supportedSystems '[ \"x86_64-linux\" ]' -A manual --no-out-link) nixos/index.html";
    nix-outpath = "nix-build --no-out-link '<nixpkgs>' -A";
    nix-position = "function __nix-position() { nix-instantiate '<nixpkgs>' --eval -A $1.meta.position; }; __nix-position";
    nix-build--no-out-link = "nix-build --no-out-link";
    nix-build-callPackage = ''function __nix-build-callPackage() { nix-build -E "with import <nixpkgs> {}; callPackage ''$1 {}"; }; __nix-build-callPackage'';
    nix-shell-callPackage = ''function __nix-shell-callPackage() { nix-shell -E "with import <nixpkgs> {}; callPackage ''$1 {}"; }; __nix-shell-callPackage'';
    nixos-generations = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";

  };
}
