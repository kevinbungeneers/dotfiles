{
  enable = true;
  terminal = "screen-256color";
  prefix = "`";
  extraConfig = ''
    # allow terminal scrolling
    set-option -g terminal-overrides 'xterm*:smcup@:rmcup@'
  '';
}