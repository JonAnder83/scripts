#
# ~/.bashrc
#

# Dependencies: sysstat and xmlstarlet

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -hali'
feed() {
  echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news//// | sed -e ':a;N;$!ba;s/\n/ /g') | \
  sed -e 's/&gt;/  /g' |
  sed -e 's/&lt;\/a  /  /g' |
  sed -e 's/href\=\"/  /g' |
  sed -e 's/<title>/\\n\\n\\n   :: \\e[01;31m/g' -e 's/<\/title>/\\e[00m ::\\n/g' |
  sed -e 's/<link>/ [ \\e[01;36m/g' -e 's/<\/link>/\\e[00m ]/g' |
  sed -e 's/<description>/\\n\\n\\e[00;37m/g' -e 's/<\/description>/\\e[00m\\n\\n/g' |
  sed -e 's/&lt;p  /\n/g' |
  sed -e 's/&lt;b  \|&lt;strong  /\\e[01;30m/g' -e 's/&lt;\/b  \|&lt;\/strong  /\\e[00;37m/g' |
  sed -e 's/&lt;a[^  ]*  \([^\"]*\)\"[^  ]*  \([^  ]*\)[^  ]*  /\\e[01;32m\2\\e[00;37m \\e[01;34m[ \\e[01;35m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g' |
  sed -e 's/&lt;li  /\n \\e[01;34m*\\e[00;37m /g' |
  sed -e 's/<[^>]*>/ /g' |
  sed -e 's/&lt;[^  ]*  //g' |
  sed -e 's/[      ]//g')\n\n"
}

feed_headers() {
        curl -s "https://www.archlinux.org/feeds/news/" | xmlstarlet sel -T -t -m /rss/channel/item -v "concat(pubDate,': ',title)" -n
}


alias upt='pacaur -Suy --noconfirm'
alias kk='sudo systemctl stop kodi && startx'
alias lsorphans='sudo pacman -Qdt'
alias rmorphans='sudo pacman -Rs $(pacman -Qtdq)'

#PS1='[\u@\h \W]\$ '
PS1='\[`[ $? = 0 ] && X=2 || X=1; tput setaf $X`\]\h\[`tput sgr0`\]:$PWD\n\$ '

# Banner
clear
screenfetch
echo "=================================== System Usage ==================================="
mpstat
echo "===================================== FS Usage ====================================="
df -hT --type=btrfs --type=zfs
echo "======================================= Alias ======================================"
alias
echo "===================================== Arch News ===================================="
feed_headers
