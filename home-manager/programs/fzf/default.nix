{
  enable = true;
  enableZshIntegration = true;
  enableFishIntegration = true;
  defaultCommand = "fd --type f";
  defaultOptions = [
    "--cycle"
    "--height 100%"
    "--border"
    "--layout=reverse"
    "--preview-window=wrap"
    "--marker=*"
    "--prompt='❱ '"
    "--border='none'"
  ];
  fileWidgetCommand = "fd --type f";
  fileWidgetOptions = [
    "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
  ];
  changeDirWidgetCommand = "fd --type d";
  changeDirWidgetOptions = [
    "--preview 'lsd --tree {} | head -200'"
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