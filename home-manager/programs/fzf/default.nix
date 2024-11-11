{
  enable = true;
  enableZshIntegration = true;
  enableFishIntegration = true;
  defaultCommand = "fd --type f --strip-cwd-prefix";
  defaultOptions = [
    "--cycle"
    "--height 100%"
    "--border"
    "--layout=reverse"
    "--preview-window=wrap"
    "--marker=*"
    "--prompt='❱ '"
    "--border='none'"
    "--with-shell='$HOME/.nix-profile/bin/fish -c'"
  ];
  fileWidgetCommand = "fd --type f --strip-cwd-prefix";
  fileWidgetOptions = [
    "--preview '_fzf_file_preview {}'"
  ];
  changeDirWidgetCommand = "fd --type d --max-depth 5";
  changeDirWidgetOptions = [
    "--preview '_fzf_dir_preview {}'"
  ];
  colors = {
    # These are ANSI colors. Apple Terminal does not support 24-bit colors.
    "prompt"  = "-1";
    "gutter"  = "-1";
    "pointer" = "1";
    "marker"  = "1";
    "info"    = "3";
    "spinner" = "5";
  };
}