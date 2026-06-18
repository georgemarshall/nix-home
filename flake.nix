{
  description = "Home Manager configuration of echos";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            # Overlay for llama-cpp with diffusion support patches
            llama-cpp =
              (prev.llama-cpp.override {
                cudaSupport = true;
              }).overrideAttrs
                (old: {
                  version = "24423";
                  src = final.fetchFromGitHub {
                    owner = "ggml-org";
                    repo = "llama.cpp";
                    rev = "9b4dae8"; # head commit of the PR — update as it progresses
                    hash = "sha256-z00F+IWcZgbFZoCaIZFubSl1JabJ3Knvg9O9F+x3Ztk=";
                  };
                  npmRoot = "tools/ui";
                  npmDepsHash = "sha256-pjdbI6NcZRlJVd62xhgbLhWrwFYwgsIwjORqvo1+VD8=";
                  cmakeFlags = (old.cmakeFlags or [ ]) ++ [
                    (final.lib.cmakeBool "LLAMA_BUILD_EXAMPLES" true)
                  ];
                });
          })
        ];
      };
    in
    {
      homeConfigurations."echos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
