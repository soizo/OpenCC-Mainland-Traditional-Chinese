.PHONY: build validate help

DICT_DIR := s2mt
OCD2_DIR := $(DICT_DIR)/ocd2

## build: 將 .txt 詞庫編譯為 .ocd2 二進制格式（需安裝 OpenCC）
build:
	@echo "==> 編譯詞庫..."
	cd $(DICT_DIR) && bash to_ocd2.sh
	@echo "==> 完成：$(OCD2_DIR)/"

## validate: 檢查詞庫文件格式（UTF-8、無重複鍵等）
validate:
	@echo "==> 檢查詞庫格式..."
	@bash scripts/validate.sh

## help: 顯示此幫助信息
help:
	@grep -E '^## ' Makefile | sed 's/^## /  /'
