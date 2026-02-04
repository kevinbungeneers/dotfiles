{
  programs.fish = {
    enable = true;

    shellInit = ''
      # Source the nix daemon
      if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      end

      # Activate mise for this session
      if test -x $HOME/.local/bin/mise
        eval "$($HOME/.local/bin/mise activate fish)"
      end

      # Disable the fish greeting
      set -g fish_greeting

      # $PATH stuff
      fish_add_path -p /Applications/Sublime\ Text.app/Contents/SharedSupport/bin
      fish_add_path -p /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
      fish_add_path -p $HOME/Library/Application\ Support/JetBrains/Toolbox/scripts
      type -q go && fish_add_path -p (go env GOPATH)"/bin"

      # CTRL+G CTRL+L for browsing Git Log, using fzf
      bind \cg\cl _fzf_git_log

      # CTRL+G CTRL+B for browsing Git Branches, using fzf
      bind \cg\cb _fzf_git_branches
    '';

    shellAliases = {
      cat = "bat --paging=never";
      doco = "docker compose";
    };

    functions = {
      fish_prompt = {
        description = "A very minimal prompt.";
        body = ''
          echo '❱ '
        '';
      };

      add_newline = {
        description = "Adds a newline after command output";
        onEvent = "fish_postexec";
        body = ''
          echo -ne '\n'
        '';
      };

      _fzf_file_preview = {
        description = "Function for previewing files in fzf, using bat.";
        body = ''
          if test -f $argv
            bat --style=numbers --color=always --line-range :500 $argv
          end
        '';
      };

      _fzf_dir_preview = {
        description = "Function for previewing directories in fzf, using lsd.";
        body = ''
          if test -d $argv
            lsd --tree -I node_modules -I .git --depth 4 --color always $argv
          end
        '';
      };

      _fzf_git_check = {
        description = "Helper function to check if we're in a git repository";
        body = ''
          git rev-parse --git-dir >/dev/null 2>&1 && return

          set_color red
          echo -ne "\nNot in a git repository\n"
          set_color normal

          commandline --function repaint

          return 1
        '';
      };

      _fzf_git_log = {
        description = "Search the output of git log and preview commits";
        body = ''
          _fzf_git_check || return

          # %h gives you the abbreviated commit hash, which is useful for saving screen space, but we will have to expand it later below
          set -f fzf_git_log_format '%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'

          set -f preview_cmd 'git show --color=always --stat --patch {1} | delta --side-by-side --paging=never --line-numbers -w $FZF_PREVIEW_COLUMNS'

          set -f selected_log_lines (
            git log --no-show-signature --color=always --format=format:$fzf_git_log_format --date=short | \
            fzf --ansi \
                --multi \
                --scheme=history \
                --prompt="Git Log ❱ " \
                --preview=$preview_cmd \
                --preview-window='down,50%,border-top' \
                --query=(commandline --current-token)
          )

          if test $status -eq 0
            for line in $selected_log_lines
              set -f abbreviated_commit_hash (string split --field 1 " " $line)
              set -f full_commit_hash (git rev-parse $abbreviated_commit_hash)
              set -f --append commit_hashes $full_commit_hash
            end
            commandline --current-token --replace (string join ' ' $commit_hashes)
          end

          commandline --function repaint
        '';
      };

      _fzf_git_branches = {
        description = "Search the output of git branch and preview the log for the selected branch";
        body = ''
          _fzf_git_check || return

          set -f selected_branch (
            git branch --sort=-committerdate --sort=-HEAD --format='%(HEAD)$#$%(color:yellow)%(refname:short)$#$%(color:green)(%(committerdate:relative))$#$%(color:blue)%(subject)%(color:reset)' --color=always | column -ts'$#$' | sed 's/^...//' |
            fzf --ansi \
                --prompt="Git Branches ❱ " \
                --tiebreak=begin \
                --preview-window=down,border-top,40% \
                --color hl:underline,hl+:underline \
                --no-hscroll \
                --preview="git log --oneline --graph --date=short --color=always --pretty='format:%C(auto)%cd %h%d %s' \$(echo {} | cut -d' ' -f1) --" $argv | cut -d' ' -f1
          )

          if test $status -eq 0
            commandline --current-token --replace $selected_branch
          end

          commandline --function repaint
        '';
      };
    };
  };
}
