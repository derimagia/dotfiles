# Unused XDG Config

```sh
# AWS
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials

# Ansible
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME"/ansible/ansible.cfg

# Azure
export AZURE_CONFIG_DIR="$XDG_CONFIG_HOME"/azure

# babel-node
export BABEL_CACHE_PATH="$XDG_CACHE_HOME"/node/babel.cache.json

# Java
export JAVA_TOOL_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# k8s
export -TU KUBECONFIG kubeconfig=("$XDG_CONFIG_HOME"/kube/config.yaml "$XDG_CONFIG_HOME"/kube/*.yaml(N))

# httpie
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie

# Intellij
export IDEA_PROPERTIES="$XDG_CONFIG_HOME"/intellij-idea/idea.properties
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME"/intellij-idea/idea.vmoptions

# Jupyterlab
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export JUPYTERLAB_DIR="$XDG_DATA_HOME"/jupyter/lab

# Xinit
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# History Files
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/history
export PSQL_HISTORY="$XDG_CACHE_HOME"/pg/psql_history

# NVIDIA
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv/ComputeCache
[[ -d $CUDA_CACHE_PATH ]] || mkdir -p $CUDA_CACHE_PATH

# KDEHOME
export KDEHOME="$XDG_CONFIG_HOME"/kde

# Ruby
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
```
