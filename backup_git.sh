
#!/bin/bash
# === 參數檢查 ===
if [ -z "$1" ]; then
    echo "❌ 錯誤：請提供要備份的目錄路徑"
    echo "用法：$0 <路徑>"
    echo "範例：$0 release/"
    exit 1
fi

target_dir=$1
# 檢查 target_dir 變數中是否包含斜線 (/)
if [[ "$target_dir" == */* ]]; then
    # --- 情況一：包含斜線 (例如：openbmc/abc/d) ---
    # 1. 取得第一個目錄名稱 (從結尾刪除最短的 /*)
    first_component="${target_dir%%/*}"
    # 結果：openbmc
    # 2. 取得剩餘的路徑 (從開頭刪除最短的 */)
    remaining_path="${target_dir#*/}"
    # 結果：abc/d
else
    # --- 情況二：不包含斜線 (例如：openbmc) ---
    # 1. 第一個目錄名稱就是整個 target_dir
    first_component="$target_dir"
    # 結果：openbmc
    # 2. 剩餘路徑設定為使用者要求的 "."
    remaining_path="."
    # 結果：. (dot)
fi

# 輸出檢查結果 (僅供測試參考)
echo "target_dir: $target_dir"
echo "first_component: $first_component"
echo "remaining_path: $remaining_path"

current_dir=$(basename "$PWD")
timestamp=$(date +%Y%m%d_%H%M%S)
backup_name="gitbackup_${current_dir}_$timestamp"
backup_dir="${PWD}/${backup_name}"
backup_log_dir=${backup_dir}/log

mkdir -p ${backup_log_dir}
log_file="${backup_log_dir}/changed_files_$timestamp.log"
fail_log="${backup_log_dir}/failed_to_backup_$timestamp.log"
deleted_log="${backup_log_dir}/deleted_files_$timestamp.log"

touch ${log_file}
touch ${fail_log}
touch ${deleted_log}

echo "🚀 備份開始，來源範圍：$remaining_path"
echo "📂 備份目的地：$backup_dir"
echo

pushd ${first_component}
repo_root=$(git rev-parse --show-toplevel)
# === 處理變更與新增檔案 (含 untracked) ===
git status --porcelain "$remaining_path" | grep -E '^(M |MM| M|A | A|\?\?)' | while IFS= read -r line; do
    status="${line:0:2}"
    file="${line:3}"
    full_path="$repo_root/$file"
    relative_path="${file#$remaining_path/}"
    dest_path="$backup_dir/$relative_path"
    dest_dir=$(dirname "$dest_path")

    echo "📄 處理中：$file"
    if [ -f "$full_path" ]; then
        mkdir -p "$dest_dir"
        cp "$full_path" "$dest_path"
        echo "$file" >> "$log_file"
        echo "✅ 備份成功：$file"
    else
        echo "$file" >> "$fail_log"
        echo "⚠️ 無法備份 (可能已刪除或非 regular file)：$file"
    fi
done

# === 另外紀錄已刪除的檔案 ===
git status --porcelain "$remaining_path" | grep -E '^( D|D )' | while IFS= read -r line; do
    echo "line:${line}"
    file="${line:3}"
    if [ -n "$file" ]; then
        echo "$file" >> "$deleted_log"
        echo "🗑️ 偵測到刪除：$file"
    fi
done
popd

# === 統計與總結 ===
success_count=$(wc -l < "$log_file")
fail_count=$(wc -l < "$fail_log")
deleted_count=$(wc -l < "$deleted_log")

echo
echo "🎉 備份完成"
echo "✅ 成功備份檔案數量：$success_count"
echo "❌ 無法備份檔案數量：$fail_count"
echo "🗑️ 偵測刪除檔案數量：$deleted_count"

cp -Rdp ${backup_dir} ${HOME}/pj/backup/
pushd ${HOME}/pj/
${HOME}/pj/sync_data_to_other.sh backup/${backup_name}
popd
