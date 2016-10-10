#!/usr/bin/env zsh

alias d="drush"
alias dr="docker"
alias drc="docker-compose"
alias dl='docker ps -l -q'
alias dps='docker ps'
alias di='docker images'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
alias docker-clean-containers='command docker ps -aqf status=exited | xargs -r docker rm -v'
alias docker-clean-images='command docker images -aqf dangling=true | xargs -r docker rmi'
alias docker-clean-volumes='command docker volume ls -qf dangling=true | xargs -r docker volume rm'
