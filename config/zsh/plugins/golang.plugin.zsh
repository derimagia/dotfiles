typeset -TUx GOPATH gopath

gopath=(
    $XDG_DATA_HOME/go
)

path=(${^gopath}/bin $path)
