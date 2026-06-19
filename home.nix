{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "echos";
  home.homeDirectory = "/home/echos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # 3D Printing
    bambu-studio
    orca-slicer

    # AI
    llama-cpp
    lmstudio
    # vllm

    # Browsers
    firefox-devedition

    # Media
    davinci-resolve-studio
    vlc

    # Security / passwords
    bitwarden-desktop

    # Editors / IDE helpers
    binwalk
    jetbrains-toolbox

    # Hardware utilities
    wootility

    # CLI/dev tools for user sessions
    devenv
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/echos/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  programs = {
    bat.enable = true;

    claude-code.enable = true;
    codex.enable = true;

    discord = {
      enable = true;
      settings = {
        openH264Enabled = true;
        offloadAdmControls = true;
      };
    };

    gh.enable = true;

    ghostty = {
      enable = true;
      settings = {
        theme = "Solarized Dark Patched";
        font-size = 10;
      };
      installBatSyntax = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      settings = {
        user.name = "George Marshall";
        user.email = "george@georgemarshall.name";
        safe.directory = [ "/etc/nixos" ];
      };
    };

    helix = {
      defaultEditor = true;
      enable = true;

      settings = {
        theme = "darcula";
      };
    };

    htop.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
      ];
    };

    spotify-player.enable = true;

    zed-editor = {
      enable = true;
      extensions = [
        "elixir"
        "material-icon-theme"
        "new-darcula"
        "nix"
        "toml"
      ];
    };

    zsh = {
      enable = true;
      prezto = {
        enable = true;
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "git"
          "completion"
          "autosuggestions"
          "syntax-highlighting"
          "prompt"
        ];
        editor.keymap = "emacs"; # or "vi" if you prefer vi bindings
      };
    };
  };
}
