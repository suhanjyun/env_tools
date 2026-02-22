
echo "tools alias configuration 20251230"
alias ls='ls --color=auto -F --group-directories-first --time-style="+"%d.%m.%Y %H:%M"'
alias ll='ls -alhF'

TOOLS_PATH="/home2/${USER}/pj/tools"

backupgit() {
    #echo "Executing backup_git ${1} in ${TOOLS_PATH}"
    #backupgit .
    pushd ${PWD}
    ${TOOLS_PATH}/backup_git.sh ${1}
    popd
}

# finds 2004-Remove-some-Lego-code-ip-can-capture.patch ./build
finds() {
    #echo "Executing finds ${1} in ${TOOLS_PATH}"
    #finds "abc" ./build
    pushd ${PWD}
    ${TOOLS_PATH}/finds.sh ${1} ${2}
    popd
}

# 同時搜尋兩個關鍵字 (*)，排除 build tmp
greps() {
    #greps.sh "(abc, dev)" "build tmp"
    pushd ${PWD}
    ${TOOLS_PATH}/greps.sh ${1} ${2}
    popd
}

# 僅匹配整個單字 (避免 temperature 誤匹配到 temperatureSensor) :
grepdm() {
    #echo "Executing grepdm ${1} in ${TOOLS_PATH}"
    #grepdm "gpio" "*.cpp" "*.hpp"
    pushd ${PWD}
    ${TOOLS_PATH}/grepdm.sh ${1} ${2} ${3}
    popd
}

# 匹配包含單字
grepd() {
    #echo "Executing grepd ${1} in ${TOOLS_PATH}"
    #grepd "gpio" "*.cpp" "*.hpp"
    pushd ${PWD}
    ${TOOLS_PATH}/grepd.sh ${1} ${2} ${3}
    popd
}

# 會顯示 git remote -v
findr() {
    #echo "Executing findr ${1} in ${TOOLS_PATH}"
    #findr "abc"
    pushd ${PWD}
    ${TOOLS_PATH}/findr.sh ${1}
    popd
}

findgitlog() {
    # 1) 根據作者姓名 (支援正規表達式)
    # ${TOOLS_PATH}/find-by-gitlog.sh --author "Johnny Su"

    # 2) 根據作者姓名 (多位，用 |)
    # ${TOOLS_PATH}/find-by-gitlog.sh --author "Johnny Su|Ryan Zhou"

    # 3) 根據日期 (起始)
    # ${TOOLS_PATH}/find-by-gitlog.sh --since "2025-01-01"

    # 4) 根據日期範圍 (含端點)
    # ${TOOLS_PATH}/find-by-gitlog.sh --since "2024-09-01" --until "2024-09-30"

    # 5) 作者 AND 日期 (預設邏輯)
    # ${TOOLS_PATH}/find-by-gitlog.sh --author "johnny" --since "2024-01-01" --until "2024-12-31"

    # 6) 改為 OR 邏輯 (作者或日期其一符合即列出)
    # ${TOOLS_PATH}/find-by-gitlog.sh --author "johnny" --since "2024-01-01" --or

    LOG_FILE="findgitlog.log"
    rm -rf ${LOG_FILE}
    touch ${LOG_FILE}
    ${TOOLS_PATH}/find-by-gitlog.sh "$@" 2>&1 | tee ${LOG_FILE}
}

csize() {
    du -sh * 2>/dev/null | sort -h
}

vdiff() {
    vimdiff <(xxd ${1}) <(xxd ${2})
}

grepgit() {
    git log --grep=${1}
}
