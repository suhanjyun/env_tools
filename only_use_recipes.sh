
#!/bin/bash
#only_use_recipes.sh
set -euo pipefail

showrecipes="show-recipes.log"
rm -rf ${showrecipes}
touch ${showrecipes}

# 會用到的 recipes
TARGET="${1:-smci-intel-smciformat-image}"

# 生成依賴與建置清單
bitbake -g "$TARGET"

echo "列出所有 recipes 與其 layer 到 ${showrecipes}"
bitbake-layers show-recipes > ${showrecipes}

echo "== Used recipes for $TARGET =="
# 交集：只顯示會被建置的 recipes, 附帶 layer 與版本
grep -F -f pn-buildlist ${showrecipes} | sort
