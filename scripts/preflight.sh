#!/usr/bin/env bash

set -euo pipefail
echoerr() { echo "$@" >/dev/stderr; }
err() {
  echoerr ""
  echoerr "$@" && exit 1
}

manual_steps=()
extra_setup=0

printf "Checking for required utilities...  "
for cmd in docker k3d kubectl; do
  command -v "$cmd" &>/dev/null || err "${cmd} not installed"
done
echo "Utilities installed!"

extra_setup=0
echo ""

printf "Checking that the domains we're using are setup and resolvable... "
for host in cluster registry argocd otel-demo; do
  ping -c1 "${host}.localhost" &>/dev/null || {
    echoerr "${host}.localhost is not resolvable!"
    extra_setup=1
    manual_steps+=("127.0.0.1 $host.localhost")
  }
done

if [[ $extra_setup == 0 ]]; then
  echo "Hosts are configured!"
else
  echoerr "Looks like you were missing some domains"
  echoerr "You probably want to configure this in /etc/hosts"
  echoerr "Here's an example command of how you might do this."
  echoerr "v-- Please ensure you understand what it does before running this :)"
  echoerr "cat <<'EOF' | sudo tee -a /etc/hosts"
  echoerr ""
  for step in "${manual_steps[@]}"; do
    echoerr "$step"
  done
  echoerr "EOF"
fi
echo "Remember! k3d is configured to map the ingress ports 80 and 443 to different ones on the system"
echo "Port 80 for ingress is mapped to port 50080 in k3d"
echo "Port 443 for ingress is mapped to port 50443 in k3d"
echo "That means that, for example, 'http://argocd.localhost' is actually http://argocd.localhost:50080"

extra_setup=0
manual_steps=()
echo ""
