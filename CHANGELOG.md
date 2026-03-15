# 更新日誌

本項目的所有重要變更均記録于此文件。

格式遵循 [Keep a Changelog](https://keepachangelog.com/zh-TW/1.0.0/) 規範。

---

## [未發布]

### 新增
- CONTRIBUTING.md：貢獻指南
- CHANGELOG.md：更新日誌
- Makefile：常用操作快捷命令
- `.github/` 目録：Issue 模板、PR 模板、CI 工作流
- 完善 README.md：增加詞庫格式說明、目録結構、徽章

### 修正
- 部分字級映射修正（炖→燉、盡、皮划艇等）

---

## [初始版本]

### 新增
- `SMTCharacters.txt`：覆蓋《通用規範漢字表》全部 8105 字的字級映射
- `SMTPhrases.txt`：詞級映射，減少歧義轉換
- `s2mt.json`：OpenCC 配置文件（文本格式）
- `s2mt/ocd2/`：已編譯的二進制詞庫（ocd2 格式）
- `to_ocd2.sh`：文本詞庫編譯腳本
- Apache-2.0 許可證
