{
  description = "Feature Flag All The Things";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, flake-utils, nixpkgs }: {
    overlay = _: _: { };
  } // flake-utils.lib.eachSystem [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs {
        inherit system; overlays = [ self.overlay ];
        config = { allowUnfree = true; };
      };
    in
    {
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          argocd
          just
          k3d
          kubectl
          kubectx
          kubernetes-helm
          kustomize
          nodePackages_latest.pnpm
          nodejs_latest
          stern
        ];
        shellHook = ''
          export PATH="$PWD/slides/node_modules/.bin:$PATH"
          export KUBECONFIG="$PWD/cluster/.kube/config"
          export ARGOCD_OPTS="--grpc-web --insecure"
          just 2>/dev/null
        '';
      };
    });
}
