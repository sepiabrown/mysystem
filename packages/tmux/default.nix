{ runCommand, makeWrapper, tmux }:

runCommand "mytmux" { buildInputs = [ makeWrapper ]; } ''
  makeWrapper ${tmux}/bin/tmux $out/bin/tmux --add-flags "-f ${./tmux.conf}"
''
#runCommand "mytmux" { nativeBuildInputs = [ makeWrapper ]; } ''
#  wrapProgram ${tmux}/bin/tmux --add-flags "-f ${./tmux.conf}"
#''
# wrapProgram tries to make new path under nix store!
