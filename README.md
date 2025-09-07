# OpenCC-Mainland-Traditional-Chinese

大陸繁體中文詞庫方案

基于 [OpenCC](https://github.com/BYVoid/OpenCC) 的轉换方案，提供「通用規範漢字表」對照的繁體中文（大陸繁體）轉换。

## 項目簡介

本項目旨在構建一個符合《通用規範漢字表》（2013，中國大陸官方發布，收録 8105 字）的繁體字轉换方案。與常見的「簡繁轉换」不同，本方案聚焦于 **簡體 ▶ 繁體（大陸正體寫法）** 的映射。

目標是爲教育、出版、文本處理和個人書寫場景提供一個精確、可控的轉换工具。

## 特性

-   覆蓋《通用規範漢字表》全部 8105 個漢字
-   目前僅支持單向轉换：簡體 → 大陸繁體
-   字級規則與詞級規則分離，减少誤轉
-   保持與 OpenCC 原有框架兼容，可直接在命令行或應用中使用

## 使用方法

### 1. 安裝 OpenCC

```bash
   sudo apt install opencc
```

或在 macOS 上

```bash
   brew install opencc
```

### 2. 克隆本倉庫

```bash
   git clone https://github.com/soizo/OpenCC-Mainland-Traditional-Chinese.git
   cd OpenCC-Mainland-Traditional-Chinese
```

### 3. 運行轉换

```bash
   opencc -i input.txt -o output.txt -c s2mt.json   # 簡體 -> 大陸繁體
```

## 示例

輸入：

```
重慶是中國西南地區的重要城市。
```

輸出（簡體 → 大陸繁體）：

```
重慶是中國西南地區的重要城市。
```

## 狀態

-   字級映射：持續完善中
-   詞級映射：持續完善中

## 貢獻

歡迎提交 Issue 或 Pull Request：

-   補充詞彙
-   報告錯誤或歧義
-   提供測試案例

## License

[Apache-2.0 License](LICENSE)
