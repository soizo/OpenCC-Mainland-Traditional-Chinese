#!/usr/bin/env bash
# 詞庫格式驗證腳本
set -euo pipefail

FAILED=0

check_encoding() {
  local f="$1"
  if ! file "$f" | grep -qE 'UTF-8|ASCII'; then
    echo "[錯誤] $f：文件編碼不是 UTF-8"
    FAILED=1
  else
    echo "[  OK] $f：編碼 UTF-8"
  fi
}

check_duplicates() {
  local f="$1"
  local dupes
  dupes=$(grep -v '^#' "$f" | grep $'\t' | awk -F'\t' '{print $1}' | sort | uniq -d)
  if [ -n "$dupes" ]; then
    echo "[警告] $f：發現重複鍵（最後一條生效，其餘將被忽略）："
    echo "$dupes" | sed 's/^/       /'
  else
    echo "[  OK] $f：無重複鍵"
  fi
}

count_entries() {
  local f="$1"
  local count
  count=$(grep -v '^#' "$f" | grep -c $'\t' || true)
  echo "[INFO] $f：$count 條有效映射"
}

DICT_DIR="$(dirname "$0")/../s2mt"

for f in "$DICT_DIR/SMTCharacters.txt" "$DICT_DIR/SMTPhrases.txt"; do
  if [ ! -f "$f" ]; then
    echo "[錯誤] 找不到文件：$f"
    FAILED=1
    continue
  fi
  check_encoding "$f"
  check_duplicates "$f"
  count_entries "$f"
  echo
done

if [ "$FAILED" -ne 0 ]; then
  echo "驗證失敗，請修正上述錯誤。"
  exit 1
else
  echo "所有檢查通過。"
fi
