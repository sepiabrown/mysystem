let

  jj = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXifjBn6gkBCKkpJJAbB1pJC1zSUljf8SFnPqvB6vIR";

  lima = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAk5gjbS/g47ORTjy+ywpQX2zQ5oNL+sTXrnKgr/8Jrw";
  urubamba = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOpfMBpKwyVj6WAdMbNoDvH3v68C0oiQoqf5EvLBcYAJ";
  bogota = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl5/ozkuWmVXtqSOJetfMA1OWF+LZ4IqsYkNhsQcGb6";
  lapaz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKa+MtYN20MlkctttUkg2RpOTNLRbfvqeTLwqbJoUj2o";
  antofagasta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYe7j/BoueCTsYF4BrNojPC+Y0MMCDqia4QkS7KmVNG";
  giron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7qlu4YKYbtjN4oLFC9VQZYFWEGnpkHYt7MsF1+dHt6";
  atacama = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDHDPbMcRRRY54ObB8+v2Ir1Y8bol7Di11AS880CLwK0";

  systems = [ lima urubamba bogota lapaz antofagasta giron atacama ];

in
{

  # pubkey = A0nB+yJRcUHqIC4PzFN8EgYcvVyYek0kJReYOGLLLHA=
  "wg-lima.age".publicKeys = [ jj lima ];

  # pubkey = EXbdmddEY2KMf+Z2eb77gWrSCsAAJQiS1LDXa1nCElk=
  "wg-urubamba.age".publicKeys = [ jj urubamba ];

  # pubkey = /P8HtebCmkXt+17xEeCsMpzsukG2ZpCm8Lh6jjsgRzo=
  "wg-bogota.age".publicKeys = [ jj bogota ];

  # pubkey = 35WCxg6asdsW7+v67RO9eG+/mVG4pbYz0bJtvxyR5Cc=
  "wg-lapaz.age".publicKeys = [ jj lapaz ];

  # pubkey = 9FS4y8jInY0xizUqAZvONoaTYL6ZN+MyngmPDi5HNHo=
  "wg-antofagasta.age".publicKeys = [ jj antofagasta ];

  # pubkey = CSDp+z+0Bb7twf55hIoBVk7VYGJ58TPWmT7SvYMW/3E=
  "wg-giron.age".publicKeys = [ jj giron ];

  # pubkey = CQYGMmwwS+Nd2SZ+GMykEKCGgoDgtbLcX0Ykwwemr2U=
  "wg-atacama.age".publicKeys = [ jj atacama ];

  # pubkey = giron:0/bWdH7q7OTCgX8Yz4b+3utJDsVSsusLhqds/OVw5y8=
  "serve-giron.age".publicKeys = [ jj giron ];

  # swarm.key for the private ipfs
  "ipfs-swarm-key.age".publicKeys = [ jj ] ++ systems;

  # peerix key, pubkey = peerix:5In6cUHRQgQUhvnlefNBd/0e7g1TMhmck15UsJv9hxY=
  "peerix.age".publicKeys = [jj] ++ systems;

}
