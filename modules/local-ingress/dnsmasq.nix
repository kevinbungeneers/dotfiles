{ config, lib, ... }:

{
    services.dnsmasq = {
        enable = true;
        addresses = lib.genAttrs config.localIngress.tlds (_: "127.0.0.1");
    };
}