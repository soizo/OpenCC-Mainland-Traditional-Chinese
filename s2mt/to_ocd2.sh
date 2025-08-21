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

# 建立輸出資料夾
mkdir -p "$OUT_DIR"

# 轉換 .txt → .ocd2（不覆蓋原檔，輸出到 ocd2/）
# 注意：--from/--to 等價於 -f/-t，新版仍可用
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