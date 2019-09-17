# If you come from bash you might have to change your $PATH.  export PATH=$HOME/bin:/usr/local/bin:$PATH

autoload bashcompinit
bashcompinit

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#ZSH_THEME="avit"
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

source ~/.autocomplete.sh

# Enable Touchpad click
#xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1    
#xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Other stuff comes here
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Make Vim recognise the kind of Terminal being used
#export TERM="xterm-256color"

function mkcd(){
    mkdir $1
    cd $1
}

function temp(){
    python -m s_tui.s_tui
}

function open(){
    if [[ $1 == *.pdf ]]
    then
        #konsole --hold -e "okular '$1'" &
        okular $1 &
        #`okular $1`
    else
        if [[ $1 == *.tex ]]
        then
            (gummi $1)
        else
            xdg-open $1
        fi
    fi
}

function killproc(){
    proc_array=($(pgrep $1))
    for i in ${proc_array[*]}
    do
        #echo $i | (grep "^[1-9]")
        if  [[ $i =~ "^[1-9]" ]]  # =~ Regex matching
        then
           kill $i 
        fi
    done
}

export PATH=$PATH:%HOME/$USER/Downloads/geckodriver
#export NOTIFY_DB_URL=sqlite://///home/$USER/scripts/notify_run_local.db

#C, C++ instant Compilation
function op(){
    
    #a=${@}
    #accum=""
    #for var in "$@"
    #do 
    #   (( accum += $var ))
    #done
    
    #echo $accum

    if [[ $1 == *.py ]]
    then
        python $1 "${@:2}"
    else
        if [[ $1 == *.cpp ]]
        then
            CPP=$1:t:r
            g++ -o $CPP $1
            ./$CPP "${@:2}"
        else
            if [[ $1 == *.c ]]
            then
                C=$1:t:r
                gcc -o $C $1
                ./$C "${@:2}"
            fi 
        fi

   fi
}

function gremote(){

    dir=$(pwd|grep -o "[A-Za-z0-9_-]*$")
    
    if [ $# -eq 0 ]
    then
        PRIV="true"
    else
        if [ $# -eq 1 ]
        then
            if [[ $1 == "public" ]]
            then
                PRIV="false"
            else
                PRIV="true"
            fi
        else
            if [ $# -eq 2 ]
            then
                if [[ $1 == "public" ]]
                then
                    PRIV="false"
                else
                    PRIV="true"
                fi
                dir=$2
            fi
        fi
    fi

function gcom(){
    git add .
    git commit -m $1
    git push
}

function gset(){
    #Sets upstream for remote pushing
    br=$(git branch | grep \* | cut -c3-)
    git push --set-upstream origin $br
}

function nmapscan(){
    arr=($(ip a | grep inet\ ))
    for i in ${arr[@]}; do ; if [[ $i =~ "/" && $i =~ "19" ]]; then a=$i; fi; done
    nmap -sn $a
}

# Man Page Decoration
# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;34m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

# Path 
#export PATH=/root/.local/bin/:$PATH
#path+=('/root/.local/bin')

#Set Alias for NeoVim
alias vim=nvim
alias vi=nvim
function viminit()
{
    vim ~/.config/nvim/init.vim
}

function vimrc()
{
    vim ~/.nvimrc
}

function changeprofile()
{
    str="$*"
    konsoleprofile ColorScheme="$str"
}

function ppt2pdf()
{
    if [[ $1 == *.pptx ]]
    then
        (fn=$1:t:r;calligrastage --export-pdf $1 --export-filename $fn.pdf)
    else
        echo "Usage: $0 *.pptx"
    fi
}

function zshrc()
{
    vim ~/.zshrc
}

function bitswifi()
{
    #cd ~/Downloads/bin; ./caa
    if [ $# -eq 1 ]
    then
        if [ $1 == "-d" ]
        then
        /home/$USER/Downloads/bin/caa -d
        else
            if [ $1 == "s" ]
            then
                /home/$USER/Downloads/bin/caa -s
            fi
        fi
    else
        /home/$USER/Downloads/bin/caa
    fi
}

function groffc()
{
    if [[ $1 == *.ms ]]
    then
        fn=$1:t:r;groff -ms $1 -T pdf > $fn.pdf
    fi
}


# -n tells `wal` to skip setting the wallpaper.
#wal -i img.jpg -n

# Using feh to tile the wallpaper now.
# We grab the wallpaper location from wal's cache so 
# that this works even when a directory is passed.

#feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"  


# You can create a function for this in your shellrc (.bashrc, .zshrc).
wal-tile() {
    a="/home/$USER/.local/share/wallpapers"
    wal -i $a/$1
    wallpaper $1
    #wal -n -i "$@"
    #feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"
}

# Usage:
#wal-tile "~/Pictures/wall.jpg"
#wal-tile "~/Pictures/tiles"

function wallpaper(){

dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var Desktops = desktops();                                                                                  
for (i=0;i<Desktops.length;i++) {    
        d = Desktops[i];    
        d.wallpaperPlugin = "org.kde.image";    
        d.currentConfigGroup = Array("Wallpaper",    
                                    "org.kde.image",    
                                    "General");    
        d.writeConfig("Image", "file:///home/$USER/.local/share/wallpapers/'$1'");
    }'

}

function kwall(){
    wallpaper $1
    fn=$1:t:r
    changeprofile $fn
    wal -i /home/$USER/.local/share/wallpapers/$1
}

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

#Needed for PyWAl
if [[ $TERM == xterm-termite ]]; then
    (cat ~/.cache/wal/sequences &)
fi

if [[ $TERM == xterm-256color ]]; then
    # Symlink the Konsole Colorscheme file
    ln -sf ~/.cache/wal/colors-konsole.colorscheme ~/.local/share/konsole 
fi

#source ~/.cache/wal/colors-tty.sh

function zat()
{
    zathura $1 &
}

function lcd()
{
    cd $1
    ls
}

function vncconnect()
{
    /home/$USER/Downloads/VNC-Viewer-6.19.715-Linux-x64
}

PATH="/home/$USER/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/$USER/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/$USER/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/$USER/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/$USER/perl5"; export PERL_MM_OPT;

#Set GOPATH
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

#Set Scripts PATH
export PATH=$PATH:$HOME/scripts

#Setting TERM when using Vim inside tmux
#[ -z "$TMUX" ] && export TERM="xterm-256color"
