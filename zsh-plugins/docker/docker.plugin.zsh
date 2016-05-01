#!/usr/bin/env zsh
alias dl='docker ps -l -q'
alias dps='docker ps'
alias di='docker images'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker-images-tree='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'
alias docker-clean-containers='docker ps -aqf status=exited | xargs docker rm -v'
alias docker-clean-images='docker images -aqf dangling=true | xargs docker rmi'
alias docker-clean-volumes='docker volume ls -qf dangling=true | xargs docker volume rm'
