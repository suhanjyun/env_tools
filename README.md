# env_tools

個人開發環境腳本與 alias：Git 備份、搜尋、Yocto/BitBake 查詢等。

---

## 使用方式

在 `~/.bashrc` 或 shell 設定裡加入：

```bash
source ~/pj/env_tools/env/bash_aliases.sh
```

會依序載入：`tools_alias.sh` → `gitconfig_alias.sh` → `yocto_alias.sh`。

> **注意**：`tools_alias.sh` 內 `TOOLS_PATH` 預設為 `/home2/${USER}/pj/tools`，若腳本實際放在本 repo，需改成 `~/pj/env_tools` 或你的路徑。`yocto_alias.sh` 已使用 `~/pj/env_tools`。

---

## 根目錄腳本

| 腳本 | 說明 | 用法 |
|------|------|------|
| **backup_git.sh** | 備份 Git 工作區中已修改/新增的檔案；刪除的檔案記到 log。備份完會複製到 `~/pj/backup/` 並呼叫 `sync_data_to_other.sh`。 | `./backup_git.sh <路徑>`，例：`./backup_git.sh release/` 或 `./backup_git.sh .` |
| **check_recipes_info.sh** | 顯示指定 recipe 的 `PV`、`FILE=`（來自 `bitbake -e`）。 | `./check_recipes_info.sh <recipe>` |
| **find_recipes.sh** | 用 `bitbake -s` 搜尋 recipe 名稱。 | `./find_recipes.sh <關鍵字>` |
| **findr.sh** | 依檔名/關鍵字找檔案，並在每個找到的目錄顯示 `git remote -v`（排除 `.git`、`node_modules`）。 | `./findr.sh <檔名或關鍵字>` |
| **finds.sh** | 依檔名 pattern 找檔案，可排除某路徑下。 | `./finds.sh <pattern> [排除路徑]`，例：`./finds.sh "*.patch" ./build` |
| **greps.sh** | 遞迴 grep 多關鍵字（OR），可排除目錄；結果同時寫入 `grepslog.log` 並輸出到 stdout。 | `./greps.sh "(關鍵字1, 關鍵字2)" "排除目錄1 排除目錄2"`，例：`./greps.sh "(abc, dev)" "build tmp"` |
| **only_use_recipes.sh** | 對給定 target 跑 `bitbake -g`，再與 `bitbake-layers show-recipes` 交集，列出「會用到的」recipes 及其 layer、版本。 | `./only_use_recipes.sh [TARGET]`，預設：`smci-intel-smciformat-image` |
| **showtaskrp.sh** | 列出指定 recipe 的 BitBake tasks（`bitbake <recipe> -c listtasks`），輸出到 `showtaskrp.log` 並 cat。 | `./showtaskrp.sh <recipe>`，例：`./showtaskrp.sh busybox` |

---

## env/ 設定檔

- **bash_aliases.sh**：入口，source 上述三個 alias 檔。
- **tools_alias.sh**：一般工具 alias（ls/ll、backupgit、finds、greps、grepd/grepdm、findr、findgitlog、csize、vdiff、grepgit 等）。部分函式會呼叫 `$TOOLS_PATH` 下的腳本（如 `backup_git.sh`、`finds.sh`、`greps.sh`、`findr.sh`、`grepdm.sh`、`grepd.sh`、`find-by-gitlog.sh`），若這些腳本在本 repo，請把 `TOOLS_PATH` 改為 `~/pj/env_tools`。
- **yocto_alias.sh**：Yocto/BitBake 用 alias，`TOOLS_PATH` 已設為 `~/pj/env_tools`，會呼叫本 repo 的 `showtaskrp.sh`、`check_recipes_info.sh`、`only_use_recipes.sh`（alias 裡寫成 `only-use-recipes.sh`，需與實際檔名 `only_use_recipes.sh` 一致或建 symlink）。
- **gitconfig_alias_sh**：Git 全域設定（user.name/email、color、core.*、alias：lg、fdiff、co、br、ci、st、type、dump 等）。檔名無 `.sh`，若用 `source` 請確認路徑；`bash_aliases.sh` 目前 source 的是 `gitconfig_alias.sh`（可能需從 `gitconfig_alias_sh` 複製或 ln）。

---

## Yocto alias 對照（yocto_alias.sh）

| alias | 說明 | 範例 |
|-------|------|------|
| showly | 顯示 layers | `bitbake-layers show-layers` |
| showlyrp | 某 recipe 來自哪個 layer | `showlyrp linux-aspeed-sdk` |
| showolrp | 同名 recipe 的覆蓋順序 | `showolrp <recipe>` |
| showaprp | 顯示 appends | `showaprp <recipe>` |
| showtaskrp | 列出 recipe 的 tasks（呼叫 showtaskrp.sh） | `showtaskrp busybox` |
| showurlrp | SRC_URI、SRCREV、PV、PR | `showurlrp virtual/kernel` |
| showinforp | PV、FILE（呼叫 check_recipes_info.sh） | `showinforp busybox` |
| showrppj | 某 image 會用到的 recipes（呼叫 only_use_recipes.sh） | `showrppj smci-intel-smciformat-image` |
| showyvalue | 查 BitBake 變數 | `showyvalue MACHINE_ARCH` |
| findtask | 在 task-depends.dot 裡找 task | `findtask obmc-phosphor-image do_merge_uboot` |
| checktaskbbclass | 需 checktaskbbclass.sh（本 repo 未含） | 見腳本內說明 |

---

## 其他

- **vim/.vimrc**：Vim 設定，可依需要 link 到 `~/.vimrc`。
