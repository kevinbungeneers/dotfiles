{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=150"
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };
}
