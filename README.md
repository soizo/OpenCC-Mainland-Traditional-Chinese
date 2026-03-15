# OpenCC-Mainland-Traditional-Chinese

[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![OpenCC Compatible](https://img.shields.io/badge/OpenCC-compatible-green.svg)](https://github.com/BYVoid/OpenCC)

大陸繁體中文詞庫方案 · Simplified-to-Mainland-Traditional Chinese Conversion for OpenCC

---

基于 [OpenCC](https://github.com/BYVoid/OpenCC) 的轉换方案，提供符合《通用規範漢字表》的繁體中文（大陸繁體）轉换。

## 目錄

- [項目簡介](#項目簡介)
- [特性](#特性)
- [安裝與使用](#安裝與使用)
- [詞庫格式](#詞庫格式)
- [目録結構](#目録結構)
- [示例](#示例)
- [狀態](#狀態)
- [貢獻](#貢獻)
- [許可證](#許可證)

## 項目簡介

本項目旨在構建一個符合《通用規範漢字表》（2013，中國大陸官方發布，收録 8105 字）的繁體字轉换方案。與常見的「簡繁轉换」不同，本方案聚焦于 **簡體 → 大陸正體** 的映射，力求：

- 字形符合大陸官方標準（而非台灣、香港寫法）
- 字級規則與詞級規則分離，减少誤轉
- 持續維護，可用于教育、出版、文本處理等場景

> **注意**：本方案爲單向轉换（簡體 → 大陸繁體），不支持反向轉换。

## 特性

- 覆蓋《通用規範漢字表》全部 **8105** 個漢字
- 詞組優先：先匹配詞級規則，再回落到字級規則，减少歧義
- 字形以大陸正體爲準，有別于台灣正體（見[示例](#示例)）
- 保持與 OpenCC 原有框架兼容，可在命令行或應用程序中直接使用
- 提供文本格式（`.txt`）及已編譯的二進制格式（`.ocd2`）

## 安裝與使用

### 1. 安裝 OpenCC

**Ubuntu / Debian**

```bash
sudo apt install opencc
```

**macOS（Homebrew）**

```bash
brew install opencc
```

**從源代碼構建**：請參閱 [OpenCC 官方文档](https://github.com/BYVoid/OpenCC#build)。

### 2. 克隆本倉庫

```bash
git clone https://github.com/soizo/OpenCC-Mainland-Traditional-Chinese.git
cd OpenCC-Mainland-Traditional-Chinese
```

### 3. 運行轉換

使用文本格式詞庫（無需額外編譯）：

```bash
opencc -i input.txt -o output.txt -c s2mt/s2mt.json
```

如需使用已編譯的二進制格式（性能更佳）：

```bash
opencc -i input.txt -o output.txt -c s2mt/ocd2/s2mt.json
```

### 4. 重新編譯二進制詞庫（可選）

若修改了 `.txt` 詞庫後，可用以下命令重新編譯：

```bash
make build
# 或手動運行
cd s2mt && bash to_ocd2.sh
```

## 詞庫格式

詞庫文件爲 TSV 格式（製表符分隔），每行一條規則：

```
<簡體字/詞>	<繁體字/詞>
```

- **`SMTCharacters.txt`**：字級映射，每個簡體字對應一個或多個繁體字（多個候選以空格分隔）。
- **`SMTPhrases.txt`**：詞級映射，整個簡體詞組對應繁體詞組。

空行和以 `#` 開頭的行爲注釋，會被 OpenCC 忽略。

**示例**（字級）：

```
爱	愛
发	髮 發
```

**示例**（詞級）：

```
发展	發展
头发	頭髮
```

## 目録結構

```
OpenCC-Mainland-Traditional-Chinese/
├── s2mt/
│   ├── SMTCharacters.txt   # 字級映射（簡體 → 大陸繁體）
│   ├── SMTPhrases.txt      # 詞級映射（簡體 → 大陸繁體）
│   ├── s2mt.json           # OpenCC 配置（文本格式）
│   ├── to_ocd2.sh          # 編譯腳本：.txt → .ocd2
│   └── ocd2/
│       ├── SMTCharacters.ocd2  # 已編譯字級詞庫
│       ├── SMTPhrases.ocd2     # 已編譯詞級詞庫
│       └── s2mt.json           # OpenCC 配置（ocd2 格式）
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## 示例

輸入（簡體）：
> 忧郁的台湾雇佣龟弑杀僵尸后颓然惊叹：为什么凛凉窑洞中，虱子剥笋兑粽子，醋坛叙蕴喂了猫猪牦蚝，仿佛只为刹那亘古功勋？凄惨葱蝎荡项链秋千呐，杨幂同伙唇气叱咤如钩岳。

輸出（大陸繁體）：
> 憂鬱的臺灣僱傭龜弑殺僵屍後頽然驚嘆：爲什麽凛凉窑洞中，虱子剥笋兑粽子，醋罎叙藴喂了猫猪牦蚝，仿佛衹爲刹那亘古功勛？凄慘葱蝎蕩項鏈鞦韆呐，楊幂同伙唇氣叱咤如鈎岳。

參考（台灣繁體，由 OpenCC 内建方案轉換）：
> 憂鬱的台灣僱傭龜弒殺殭屍後頹然驚歎：為什麼凜涼窯洞中，蝨子剝筍兌粽子，醋罈敘蘊餵了貓豬犛蠔，彷彿只為剎那亙古功勳？悽慘蔥蠍盪項鍊鞦韆吶，楊冪同夥脣氣叱吒如鉤嶽。

## 狀態

| 模塊 | 狀態 |
|------|------|
| 字級映射（SMTCharacters） | 持續完善中 |
| 詞級映射（SMTPhrases） | 持續完善中 |

## 貢獻

歡迎提交 Issue 或 Pull Request！請先閱讀 [CONTRIBUTING.md](CONTRIBUTING.md)。

常見貢獻類型：

- 補充缺失的詞彙映射
- 報告錯誤或歧義字形
- 提供測試案例或示例文本
- 改進文档

## 許可證

本項目採用 [Apache-2.0 許可證](LICENSE)。
