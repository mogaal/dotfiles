alias pc='lintian --color auto -i  --pedantic -I *.changes'
alias trabajo='ssh agarrido@10.200.3.29 -v'
alias dreamhost='ssh -v agm@ballechin.dreamhost.com'
alias copiar_movies='scp movies.db agm@ballechin.dreamhost.com:/home/agm/mogaal.com/movies'
alias clonar_debian='gbp clone --verbose --all --pristine-tar'
alias ssh_hosts='cat .ssh/config | grep Host'

# Very useful aliases
alias cps='ps aux | head -n1; ps aux | grep -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
