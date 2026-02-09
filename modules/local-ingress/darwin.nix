{
  lib,
  config,
  user,
  ...
}:

{
  imports = [
    ./shared.nix
    ./caddy.nix
    ./dnsmasq.nix
  ];

  users.knownGroups = [ "local-ingress" ];
  users.groups.local-ingress = {
    gid = config.localIngress.groupId;
    members = [
      user.name
    ];
  };
}
