
echo "yocto alias configuration"
TOOLS_PATH="/home2/${USER}/pj/env_tools"

showly() {
    echo "example:bitbake-layers show-layers"
    #pushd ${PWD}
    bitbake-layers show-layers
    #popd
}

# show info <recipes>
showlyrp() {
    echo "example:bitbake-layers show-recipes | grep linux-aspeed-sdk"
    recipes=$1
    echo "表示 linux-aspeed 這個 recipe 來自 meta-aspeed layer"
    bitbake-layers show-recipes ${recipes}
}

showolrp() {
    echo "example:如果有多個 layer 提供同名 recipe，這個指令會顯示 覆蓋順序 (哪個 layer 最終生效)"
    recipes=$1
    bitbake-layers show-overlayed ${recipes}
}

showaprp() {
    echo "example:showap <recipes> (ex. showtaskrp busybox)"
    recipes=$1
    bitbake-layers show-appends ${recipes}
}

showtaskrp() {
    echo "example:showtaskrp <recipes> (ex. showtaskrp busybox)"
    ${TOOLS_PATH}/showtaskrp.sh ${1}
}

showurlrp() {
    echo "example:showurlrp <recipes> (ex. showurlrp virtual/kernel)"
    recipes=$1
    bitbake-e ${recipes} | egrep '^SRC_URI|^SRCREV|^PV|^PR'
}

showinforp() {
    echo "example:showinforp <recipes> (ex. showinforp busybox)"
    #pushd ${PWD}
    recipes=$1
    ${TOOLS_PATH}/check_recipes_info.sh ${recipes}
    #popd
}

showrppj() {
    echo "example:showrppj <project> (ex. showrppj smci-intel-smciformat-image)"
    #pushd ${PWD}
    ${TOOLS_PATH}/only-use-recipes.sh ${1}
    #popd
}

showyvalue() {
    echo "example:showyvalue MACHINE_ARCH"
    bitbake -e | grep "^${1}"
}

findtask() {
    echo "example:findtask obmc-phosphor-image do_merge_uboot"
    bitbake -g ${1}
    grep -irHn "${2}" task-depends.dot
    echo "Output:task-depends.dot"
}

checktaskbbclass() {
    echo "example:checktaskbbclass . image_types_phosphor_aspeed_g7.bbclass(content) run.do_merge_uboot(file)"
    ${TOOLS_PATH}/checktaskbbclass.sh ${1} ${2} ${3}
}
