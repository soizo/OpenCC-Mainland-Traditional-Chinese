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

简体：
```
忧郁的台湾雇佣龟弑杀僵尸后颓然惊叹：为什么凛凉窑洞中，虱子剥笋兑粽子，醋坛叙蕴喂了猫猪牦蚝，仿佛只为刹那亘古功勋？凄惨葱蝎荡项链秋千呐，杨幂同伙唇气叱咤如钩岳。
```

大陸繁體：
```
憂鬱的臺灣僱傭龜弑殺僵屍後頽然驚嘆：爲什麽凛凉窑洞中，虱子剥笋兑粽子，醋罎叙藴喂了猫猪牦蚝，仿佛衹爲刹那亘古功勛？凄慘葱蝎蕩項鏈鞦韆呐，楊幂同伙唇氣叱咤如鈎岳。
```

台灣繁體：
```
憂鬱的台灣僱傭龜弒殺殭屍後頹然驚歎：為什麼凜涼窯洞中，蝨子剝筍兌粽子，醋罈敘蘊餵了貓豬犛蠔，彷彿只為剎那亙古功勳？悽慘蔥蠍盪項鍊鞦韆吶，楊冪同夥脣氣叱吒如鉤嶽。
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
