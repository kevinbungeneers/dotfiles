{
  programs.ssh = {
    enable = true;

    matchBlocks."*" = {
      extraOptions = {
        IgnoreUnknown = "UseKeychain";
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
      };
    };
  };
}