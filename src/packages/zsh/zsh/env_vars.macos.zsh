export PATH=~/.nix-profile/bin:/opt/homebrew/bin:/opt/homebrew/sbin:~/.local/bin:~/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_CELLAR=/opt/homebrew/Cellar
export HOMEBREW_REPOSITORY=/opt/homebrew
export INFOPATH=/opt/homebrew/share/info:$INFOPATH
export KUBECONFIG=~/.kube/config-atbay
export LD_LIBRARY_PATH=/opt/homebrew/lib:$LD_LIBRARY_PATH
export JAVA_HOME=@java_home@

if [[ -e .venv/bin/activate ]]; then
  source .venv/bin/activate
fi
