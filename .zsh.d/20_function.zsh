is_mac() {
    if [ `uname` = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

is_exists() {
    if type $1 > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

memo() {
    today_formatted=`date '+%Y_%m_%d'`
    memo_filename=$today_formatted'.md'
    memo_dir=$HOME'/Documents/daily_report/'
    memo_path=$memo_dir$memo_filename

    if ! is_exists code; then
        echo "not found code command."
        exit 1
    fi

    if [ ! -e $memo_dir ]; then
        mkdir -p $memo_dir
    fi

    if [ -f $memo_path ]; then
        code $memo_path
    else
        echo '# '$today_formatted > $memo_path
        code $memo_path
    fi
}

select-snippets() {
    BUFFER=$(cat ~/dotfiles/document/command_snippets | grep -v '^\s*#' | grep -v '^\s*$' | fzf +m --query "$LBUFFER" --prompt="Snippet > ")
    CURSOR=$#BUFFER
}

grep-vim() {
    ret=$(grep -rn --exclude-dir=kernel $1 * | fzf | tr ':' ' ' | awk '{print $1,$2}')
    if [ -n "$ret" ]; then
        eval "arr=($ret)"
        vim "+"$arr[2] $arr[1]
    fi
}

vim-fzf-find() {
    local FILE=$(find ./ -path '*/\.*' -name .git -prune -o -type f -print 2> /dev/null | fzf +m)
    if [ -n "$FILE" ]; then
        ${EDITOR:-vim} $FILE
    fi
}

cd-fzf-find() {
    local DIR=$(find ./ -path '*/\.*' -name .git -prune -o -type d -print 2> /dev/null | fzf +m)
    if [ -n "$DIR" ]; then
        cd $DIR
    fi
}

vim-modified() {
    local FILE=$(git status --porcelain | awk '{print $2}' | fzf +m)
    if [ -n "$FILE" ]; then
        ${EDITOR:-vim} $FILE
    fi
}

