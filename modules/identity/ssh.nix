{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks."*" = {
      extraOptions = {
        IgnoreUnknown = "UseKeychain";
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
      };
    };
  };
}
