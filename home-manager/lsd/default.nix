{
  programs.lsd = {
    enable = true;
    enableAliases = true;

    settings = {
      icons = {
        when = "never"; # Possible values: always, auto, never. Requires a NerdFont when enabled.
      };
      sorting = {
        dir-grouping = "first";
      };
    };
  };
}