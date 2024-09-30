{ pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./helix.nix
    ./nvim
    ./tmux.nix
    ./wezterm.nix
  ];

  home = {
    stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      pkgs.amber
      pkgs.devenv
      pkgs.markdown-oxide
      pkgs.nixd
      pkgs.ripgrep
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = ./../.config/hammerspoon;
        target = ".hammerspoon";
        recursive = true;
      };
    };

    sessionVariables = {
    };
  };

  programs = {
    # Use fish
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # N/A
      '';

      plugins = [
      ];
    };

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    starship = {
      enable = true;

      settings = {
        command_timeout = 100;
        format = "[$all](dimmed white)";

        directory = {
          style = "bold fg";
        };

        nix_shell = {
          symbol = " ";
          style = "italic fg";
        };

        character = {
          success_symbol = "[❯](dimmed green)";
          error_symbol = "[❯](dimmed red)";
        };

        git_branch = {
          ignore_branches = [ "master" "main" ];
        };

        git_status = {
          style = "bold yellow";
          format = "([$all_status$ahead_behind]($style) )";
        };

        jobs.disabled = true;
      };
    };

    jujutsu = {
      enable = true;
    };
  };
}
