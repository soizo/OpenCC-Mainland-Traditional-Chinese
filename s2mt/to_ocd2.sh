#!/usr/bin/env bash
set -euo pipefail

# 目標輸出資料夾
OUT_DIR="ocd2"

# 來源檔（與腳本同級目錄）
CHAR_TXT="SMTCharacters.txt"
PHRA_TXT="SMTPhrases.txt"
JSON_IN="s2mt.json"   # 若你的 JSON 名稱不同，請把這行改成實際檔名

# 檢查 opencc_dict 是否存在（由 OpenCC 提供）
if ! command -v opencc_dict >/dev/null 2>&1; then
  echo "[!] 找不到 opencc_dict。請先安裝 OpenCC："
  echo "    brew install opencc"
  exit 1
fi

# 檢查來源檔
for f in "$CHAR_TXT" "$PHRA_TXT" "$JSON_IN"; do
  if [[ ! -f "$f" ]]; then
    echo "[!] 缺少必要檔案：$f"
    exit 1
  fi
done

# —— 新增：重複鍵清理（在原檔內就地加註釋） ——
# 規則：以 TAB 為分隔，視 TAB 前為鍵；若同鍵多次出現，僅最後一筆保留不註釋，其餘前面出現者加上 "# "
process_txt_inplace() {
  local file="$1"
  local tmp
  tmp="$(mktemp)"

  # 使用兩段式 AWK：先記錄每個鍵最後出現的行號，再逐行輸出，
  # 若當前行號 < 該鍵最後行號 → 在行首加 "# " 註釋；否則原樣輸出。
  # 對於不含 TAB 的行，維持原樣。
  awk '
    BEGIN { FS = "\t" }
    {
      raw[NR] = $0
      # 僅當行中含有 TAB 時才視為「有鍵」
      if (index($0, FS)) {
        key[NR] = $1
        last[$1] = NR
      } else {
        key[NR] = ""  # 無鍵
      }
    }
    END {
      for (i = 1; i <= NR; i++) {
        line = raw[i]
        k = key[i]
        if (k != "" && i < last[k]) {
          print "# " line
        } else {
          print line
        }
      }
    }
  ' "$file" > "$tmp"

  mv "$tmp" "$file"
}

echo "[…] 先處理重複鍵，僅保留最後一次出現的紀錄（其餘加註釋）"
process_txt_inplace "$PHRA_TXT"
process_txt_inplace "$CHAR_TXT"

# 建立輸出資料夾
mkdir -p "$OUT_DIR"

# 轉換 .txt → .ocd2（不覆蓋原檔，輸出到 ocd2/）
opencc_dict --input "$PHRA_TXT" --output "$OUT_DIR/SMTPhrases.ocd2" --from text --to ocd2
opencc_dict --input "$CHAR_TXT" --output "$OUT_DIR/SMTCharacters.ocd2" --from text --to ocd2

# 產生改寫後的 JSON 到 ocd2/s2mt.json（不動原始 JSON）
# 把 "type": "text" → "type": "ocd2"
# 並把 .txt 副檔名替換為 .ocd2
# 使用 BSD sed（macOS 內建）
sed \
  -e 's/"type"[[:space:]]*:[[:space:]]*"text"/"type": "ocd2"/g' \
  -e 's/\.txt"/.ocd2"/g' \
  "$JSON_IN" > "$OUT_DIR/s2mt.json"

echo "[✔] 轉換完成，輸出已放在：$OUT_DIR/"
echo "    - $OUT_DIR/SMTPhrases.ocd2"
echo "    - $OUT_DIR/SMTCharacters.ocd2"
echo "    - $OUT_DIR/s2mt.json"
echo "    （提醒）已在原始 TXT 檔內用 '# ' 註釋掉重複鍵的前面出現者，只保留最後一筆為有效紀錄。"