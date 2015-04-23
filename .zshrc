# -----------------------------
#  Saison .zshrc
#  create 2014/09/01
#  update 2015/02/12
# -----------------------------

# -----------------------------
# update log
#
# update 2015/02/12
# add alias
#
# -----------------------------

# ------------------------------
# General Settings
# ------------------------------
export LANG=ja_JP.UTF-8                               # 文字コードをUTF-8に設定
export KCODE=u                                        # KCODEにUTF-8を設定
export AUTOFEATURE=true                               # autotestでfeatureを動かす

bindkey -v                                            # キーバインドをviモードに設定

setopt auto_pushd                                     # cd時にディレクトリスタックにpushdする
# setopt correct                                      # コマンドのスペルを訂正する
setopt prompt_subst                                   # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify                                         # バックグラウンドジョブの状態変化を即時報告する
#setopt equals                                        # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit                        # 補完機能を有効にする
setopt auto_list                                      # 補完候補を一覧で表示する(d)
setopt auto_menu                                      # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed                                    # 補完候補をできるだけ詰めて表示する
setopt list_types                                     # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete                  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 補完時に大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history                               # ヒストリを保存するファイル
HISTSIZE=10000                                        # メモリに保存されるヒストリの件数
SAVEHIST=10000                                        # 保存されるヒストリの件数
setopt bang_hist                                      # !を使ったヒストリ展開を行う(d)
setopt extended_history                               # ヒストリに実行時間も保存する
setopt hist_ignore_dups                               # 直前と同じコマンドはヒストリに追加しない
setopt share_history                                  # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks                             # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%F{green}[ SaisonLab. @ %D{%m/%d %T} ]%f %F{yellow}[ %~ ]%f $ "
# tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT


#Title
precmd() {
    [[ -t 1 ]] || return
    case $TERM in
        *xterm*|rxvt|(dt|k|E)term)
        print -Pn "\e]2;[%~]\a"
	;;
        # screen)
        #      #print -Pn "\e]0;[%n@%m %~] [%l]\a"
        #      print -Pn "\e]0;[%n@%m %~]\a"
        #      ;;
    esac
}


# ------------------------------
# Git Settings
# ------------------------------
### zshプロンプト設定
# カラーの設定を$fg[red]のように人がわかるような書き方ができる
autoload -Uz colors
colors

#
# Color定義(あとで変更しやすいように)
#
DEFAULT=$'%{\e[0;0m%}'
RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BOLD_GREEN="%{${fg_bold[green]}%}"
BLUE="%{${fg[blue]}%}"
BOLD_BLUE="%{${fg_bold[blue]}%}"
RED="%{${fg[red]}%}"
BOLD_RED="%{${fg_bold[red]}%}"
CYAN="%{${fg[cyan]}%}"
BOLD_CYAN="%{${fg_bold[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
BOLD_YELLOW="%{${fg_bold[yellow]}%}"
MAGENTA="%{${fg[magenta]}%}"
BOLD_MAGENTA="%{${fg_bold[magenta]}%}"
WHITE="%{${fg[white]}%}"


setopt prompt_subst
autoload -Uz add-zsh-hook

#
# Gitの状態表示
#
# 記号について
#   - : WorkingTreeに変更がある場合(Indexにaddしていない変更がある場合)
#   + : Indexに変更がある場合(commitしていない変更がIndexにある場合)
#   ? : Untrackedなファイルがある場合
#   * : remoteにpushしていない場合
#
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
    # zshが4.3.10以上の場合
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
    zstyle ':vcs_info:git:*' formats '%s,%u%c,%b'
    zstyle ':vcs_info:git:*' actionformats '%s,%u%c,%b|%a'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    local _vcs_name _status  _branch_action
    if [ -n "$vcs_info_msg_0_" ]; then
        _vcs_name=$(echo "$vcs_info_msg_0_" | cut -d , -f 1)
        _status=$(_git_untracked_or_not_pushed $(echo "$vcs_info_msg_0_" | cut -d , -f 2))
        _branch_action=$(echo "$vcs_info_msg_0_" | cut -d , -f 3)
        psvar[1]="(${_vcs_name})-[${_status}${_branch_action}]"
    fi
    # 右側プロンプト
    RPROMPT="${RESET}%1(v|${RED}%1v|)${RESET}${BOLD_YELLOW}${VIRTUAL_ENV:+($(basename "$VIRTUAL_ENV"))}${RESET}"
}
add-zsh-hook precmd _update_vcs_info_msg

#
# Untrackedなファイルが存在するか未PUSHなら記号を出力
#   Untracked: ?
#   未PUSH: *
#
function _git_untracked_or_not_pushed() {
    local git_status head remotes stagedstr
    local  staged_unstaged=$1 not_pushed="*" untracked="?"
    # カレントがgitレポジトリ下かどうか判定
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]; then
        # statusをシンプル表示で取得
        git_status=$(git status -s 2> /dev/null)
        # git status -s の先頭が??で始まる行がない場合、Untrackedなファイルは存在しない
        if ! echo "$git_status" | grep "^??" > /dev/null 2>&1; then
            untracked=""
        fi

        # stagedstrを取得
        zstyle -s ":vcs_info:git:*" stagedstr stagedstr
        # git status -s の先頭がAで始まる行があればstagedと判断
        if [ -n "$stagedstr" ] && ! printf "$staged_unstaged" | grep "$stagedstr" > /dev/null 2>&1 \
            && echo "$git_status" | grep "^A" > /dev/null 2>&1; then
            staged_unstaged=${staged_unstaged}${stagedstr}
        fi

        # HEADのハッシュ値を取得
        #  --verify 有効なオブジェクト名として使用できるかを検証
        #  --quiet  --verifyと共に使用し、無効なオブジェクトが指定された場合でもエラーメッセージを出さない
        #           そのかわり終了ステータスを0以外にする
        head=$(git rev-parse --verify -q HEAD 2> /dev/null)
        if [ $? -eq 0 ]; then
            # HEADのハッシュ値取得に成功
            # リモートのハッシュ値を配列で取得
            remotes=($(git rev-parse --remotes 2> /dev/null))
            if [ "$remotes[*]" ]; then
                # リモートのハッシュ値取得に成功(リモートが存在する)
                for x in ${remotes[@]}; do
                    # リモートとHEADのハッシュ値が一致するか判定
                    if [ "$head" = "$x" ]; then
                        # 一致した場合はPUSH済み
                        not_pushed=""
                        break
                    fi
                done
            else
                # リモートが存在しない場合
                not_pushed=""
            fi
        else
            # HEADが存在しない場合(init直後など)
            not_pushed=""
        fi

        # Untrackedなファイルが存在するか未PUSHなら記号を出力
        if [ -n "$staged_unstaged" -o -n "$untracked" -o -n "$not_pushed" ]; then
            printf "${staged_unstaged}${untracked}${not_pushed}"
        fi
    fi
    return 0
}


# ------------------------------
# Other Settings
# ------------------------------

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


# ------------------------------
# Aliases
# ------------------------------

# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls;
}
#時刻を表示させる
alias history='history -E'

# MacVim
# alias vim=/Applications/MacVim.app/Contents/MacOS/MacVim
# alias vi=vim

alias markup='cp -r ~/dev/front-html/* ./ && npm install && atom && gulp'
alias front="cp -r ~/dev/front-package/* ./ && npm install && atom && gulp"
alias jadephp="cp -r ~/dev/jade-php-package/* ./ && npm install && atom && gulp"
alias jca="cp -r ~/dev/jc-angular/* ./ && npm install && atom && gulp"

# Command
alias la='ls -a'
alias ll='ls -l'
alias lah='ls -lah'
alias rm='rm -i'

# MySQL
alias mysql='/Applications/MAMP/Library/bin/mysql'

# npm Command
alias ns='npm start'
alias ninit='npm init'
alias ni='npm install'

# mongo start
alias smongo='sudo mongod --dbpath /var/lib/mongodb --logpath /var/log/mongodb.log'

# Eclipse
alias eclipse='/Users/tak723sio/android_sdk/platform-tools/adb kill-server && /Users/tak723sio/android_sdk/platform-tools/adb start-server && /Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse -clean'

# Sass & compass
alias cw="compass w"
alias cc="compass create --sass-dir 'sass' --css-dir 'css'"

# activator
alias actr='activator run'
alias actn='activator new'



export NODE_PATH=/usr/local/lib/node_modules:/Users/tak723sio/.nvm/v0.11.14/lib/node_modules
