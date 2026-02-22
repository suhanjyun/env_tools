
#!/bin/bash
# ==========================================================
# 用法: ./greps.sh "(關鍵字1, 關鍵字2)" "排除目錄1 排除目錄2"
# 範例: ./greps.sh "(abc, dev)" "build tmp"
# ==========================================================

# 檢查參數數量
if [ $# -lt 1 ]; then
    echo "錯誤: 至少需要一個搜尋關鍵字參數。"
    echo "用法: $0 \"(關鍵字)\" [排除目錄...]"
    exit 1
fi

# 定義輸出檔案
LOG_FILE="grepslog.log"
rm -rf ${LOG_FILE}

# ----------------------------------------------------------
# 1. 解析第 1 個參數：搜尋關鍵字 (Pattern Parser)
# ----------------------------------------------------------
# 輸入: "(abc, dev)" 或 "abc, dev"
# 目標: 轉成 "abc|dev" 讓 grep -E 使用
# 邏輯:
#   1. tr -d '()'    -> 移除左右括號
#   2. sed 's/, /|/g' -> 將 "逗號+空白" 轉為 "|"
#   3. sed 's/,/|/g'  -> 將剩餘的 "逗號" 轉為 "|" (防呆用)
SEARCH_PATTERN=$(echo "$1" | tr -d '()' | sed 's/, /|/g; s/,/|/g')

# --- 2. 處理後續所有參數：排除資料夾 (改良版) ---
# 'shift' 指令會將參數列表向左移一格 ($2 變成 $1, $3 變成 $2...)
# 我們執行一次，等於是「用掉」了第 1 個參數 (關鍵字)
shift

# 現在 "$@" 這個特殊變數代表了「所有剩餘的參數」
EXCLUDE_OPTS=""
for dir in "$@"; do
    EXCLUDE_OPTS="$EXCLUDE_OPTS --exclude-dir=$dir"
done

# ----------------------------------------------------------
# 3. 執行 grep 並輸出
# ----------------------------------------------------------
# -r : 遞迴搜尋子目錄
# -n : 顯示行號
# -E : 使用 Extended Regex (為了支援 | 語法)
# --exclude="$LOG_FILE" : 關鍵！排除輸出的 log 檔，避免搜尋到自己
# .  : 搜尋當前目錄

# (可選) 顯示執行訊息以便除錯，不需要可註解掉
echo "搜尋關鍵字: [$SEARCH_PATTERN]"
echo "排除資料夾: $EXCLUDE_OPTS"
echo "寫入檔案至: $LOG_FILE"

grep --color=always -rnE $EXCLUDE_OPTS --exclude="$LOG_FILE" "$SEARCH_PATTERN" . > "$LOG_FILE"
grep --color=always -irHn $EXCLUDE_OPTS --exclude="$LOG_FILE" "$SEARCH_PATTERN" .


