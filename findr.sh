
#!/bin/bash
# 檢查是否有輸入參數
if [ -z "$1" ]; then
    echo "使用方式: findr <檔名或關鍵字>"
    echo "範例: findr config.json"
    exit 1
fi

TARGET_FILE="$1"
echo "findr: ${1} file"
# 使用 find 搜尋檔案 (排除常見的忽略資料夾如 .git, node_modules)
find . -type d \( -name ".git" -o -name "node_modules" \) -prune -o -type f -name "$TARGET_FILE" -print | while read -r FILE_PATH
do
    # 取得檔案所在的目錄路徑
    DIR_PATH=$(dirname "$FILE_PATH")

    echo "=================================================="
    echo "找到檔案: $FILE_PATH"
    echo "所在目錄: $DIR_PATH"

    # 切換到該目錄執行 Git 指令
    # 使用 ( ) 在 subshell 執行，避免影響目前 shell 的路徑
    (
        cd "$DIR_PATH" || exit

        # 檢查是否在 git 專案內
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
            echo "Git 遠端資訊 (Remote):"
            # 使用 git remote -v 取得詳細 URL (你要求的 -r 通常是看 branch，這裡建議用 -v)
            git remote -v
        else
            echo "提示: 此目錄不在 Git 管理範圍內。"
        fi
    )
    echo ""
done


