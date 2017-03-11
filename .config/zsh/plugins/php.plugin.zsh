# Aliases for common Drush commands that work in a global context.
alias composer="php -n =composer"
alias ev='drush php-eval'
alias lsa='drush site-alias'
alias dq='drush sql-query'
alias xdrush='XDEBUG_CONFIG="idekey=PHPSTORM" drush'


path=(
    $COMPOSER_HOME/vendor/bin
    $path
)

# Lets you cd into local sites (doesn't work with vagrant)
cdd() {
    local l="$1"
    local first=${l:0:1}

    if [[ -z $1 ]] || [[ $first != "@" && $first != "%" ]]; then
        builtin cd $*
        return
    fi

    d="$(drush drupal-directory $1 --local-only 2>/dev/null)"
    if [[ $? == 0 ]]; then
        builtin cd "$d";
        return
    fi

    if drush site-alias $1 >/dev/null 2>&1; then
	    echo "Cannot cd to remote site $s" >&2
    else
	    echo "Cannot cd to $s" >&2
    fi
}

# @TODO: This needs work. =/
drush-site-set() {
	local aliasname="$1"
	local filename="/tmp/drush-env-${USER}/drush-drupal-site-$$"

	mkdir -p ${filename:h}

	if [[ -z $aliasname ]]; then
		rm -f $filename
	else
		echo $aliasname > $filename
	fi
}

# This alias allows `dssh @site` to work like `drush @site ssh`.
# Ssh commands, such as `dssh @site ls /tmp`, are also supported.
dssh() {
    d="$1"
    if [[ ${d:0:1} == "@" ]]; then
	   drush "$d" ssh "${@:2}"
	   return
    fi

    command ssh "$@"
}

dsearch() {
    data=$(curl -s https://raw.githubusercontent.com/derimagia/drupalhound/master/data/project_module-7.x-released.txt)
    for arg in $*; do
        data=$(echo $data | grep "$arg")
    done;
    ink -lc g 'D7:'
    print -l $data

    hr ' ' '-' ' '

    ink -lc g 'D8:'
    data=$(curl -s https://raw.githubusercontent.com/derimagia/drupalhound/master/data/project_module-8.x-released.txt)
    for arg in $*; do
        data=$(echo $data | grep "$arg")
    done;
    print -l $data
}
