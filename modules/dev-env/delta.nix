{
  programs.delta = {
    enable = true;

    options = {
      features = "side-by-side line-numbers decorations";
      syntax-theme = "Nord";
      whitespace-error-style = "22 reverse";
      decorations = {
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow ul";
        file-decoration-style = "none";
      };
    };
  };
}
