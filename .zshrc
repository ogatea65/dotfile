#PATH=$HOME/bin:$PATH
PATH=/sbin:$HOME/bin:/usr/local/opt/coreutils/libexec/gnubin:/bin:/usr/local/bin:/usr/bin:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:/usr/local/bin:/usr/local/bin/andloid_sdk/platform-tools:/Applications/eclipse/sdk/platform-tools:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH
#SUDO_PATH=/opt/local/bin
MANPATH=/opt/local/man:$MANPATH

# RVM
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

# JAVA_HOME 環境変数
export JAVA_HOME=$(dirname $(readlink $(which java)))/../../CurrentJDK/Home/

# hadoopの環境変数
export HSTACK_HOME=$HOME/hstack
export HADOOP_VER=0.20.205.0
export HADOOP_INSTALL=$HSTACK_HOME/hadoop-$HADOOP_VER/
export PATH=$PATH:$HADOOP_INSTALL/bin/

# pigの環境変数
export PIG_VER=0.10.0
export PIG_INSTALL=$HSTACK_HOME/pig-$PIG_VER
export PATH=$PATH:$PIG_INSTALL/bin

# hiveの環境変数
export HIVE_VER=0.8.1
export HIVE_INSTALL=$HSTACK_HOME/hive-$HIVE_VER
export PATH=$PATH:$HIVE_INSTALL/bin

# EC2-API-TOOLS
# export AWS_PATH=/Users/ogatakenta/.project/aws
# export EC2_HOME=${AWS_PATH}/ec2-api-tools
# export PATH=${PATH}:${EC2_HOME}/bin

# RDSコマンドラインツール
# export AWS_RDS_HOME=/Users/ogatakenta/.project/aws/RDSCli-1.10.003
# export PATH=$PATH:$AWS_RDS_HOME/bin
# export EC2_REGION="ap-northeast-1"
# export AWS_CREDENTIAL_FILE=/Users/ogatakenta/.project/aws/RDSCli-1.10.003/credential-file-path

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH=$PATH:$HOME/.nodebrew/current/bin

# メタ文字(*,[],?…)をファイル名解析させない
setopt nonomatch

source ~/.zsh.d/zshrc


autoload -U compinit
compinit -C



alias ll='ls -laG'
#alias mysql='/opt/local/lib/mysql5/bin/mysql'
alias pd="pushd"
alias po="popd"

# emacsのエイリアス
# brew install emacs
alias emacs="TERM=xterm-256color emacs-24.5"

# gitのエイリアス
alias g="git"


# 補完機能の強化
dl=$HOME'/Downloads'
dt=$HOME'/Desktop'
dc=$HOME'/Documents'




# Attache tmux
##if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
##    if ( tmux has-session ); then
##				session=`tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]\+\).*$/\1/'`
##				if [ -n "$session" ]; then
##						    echo "Attache tmux session $session."
##								tmux attach-session -t $session
##				else
##						    echo "Session has been already attached."
##								tmux list-sessions
##				fi
##    else
##				echo "Create new tmux session."
##				tmux
##    fi
##fi




## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
#eval `dircolors`
#export ZLS_COLORS=$LS_COLORS
#.zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## ディレクトリ名だけで cd
setopt auto_cd
## cdで移動してもpushdと同じようにディレクトリスタックに追加する。
setopt auto_pushd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

## 濁点対応
setopt COMBINING_CHARS

## git補完は普通のファイル名補完
__git_files() { _files }

## rake補完は普通のファイル名補完
_rake() { _files }


# AWS-CLI補完
##source aws_zsh_completer.sh


# SSH補完
function _ssh {
compadd `fgrep 'Host ' ~/.ssh/config | awk '{print $2}' | sort`;
}
