# OpenCC — Mainland Traditional Chinese Conversion Scheme

A Simplified-to-Mainland-Traditional-Chinese conversion scheme for [OpenCC](https://github.com/BYVoid/OpenCC), aligned with the *Table of General Standard Chinese Characters* (通用規範漢字表, 2013).

## See Also: A More Complete Approach

> **Note:** Since this project was created, a more comprehensive solution has emerged that may better suit your needs.

[**OpenCC — Traditional Chinese Characters According to Chinese Government Standards**](https://github.com/TerryTian-tech/OpenCC-Traditional-Chinese-characters-according-to-Chinese-government-standards)
by TerryTian-tech offers several advantages over this project:

- **Four conversion directions:** `s2t` (Simplified → Standard Traditional), `t2gov` (Traditional → Government-standard Traditional), `t2new` (variant → standard forms), and `t2s` (Traditional → Simplified)
- **Traditional-to-Traditional normalization:** can clean up mixed or non-standard traditional text produced by mainland input software — a use case this project does not cover
- **Richer reference base:** character mappings are cross-checked against the *Modern Chinese Dictionary* (现代汉语词典) and *Cihai* (辞海), not just the raw government table
- **Broader file format support:** handles Word documents, subtitle files (SRT, ASS/SSA, LRC), and plain text
- **Pre-compiled executables** for Windows and Linux

If you need strict government-standard compliance for publishing, or need to normalize existing traditional-character documents, consider using that project instead of or alongside this one.

---

## Background

Standard OpenCC converts Simplified Chinese to the traditional character forms used in Taiwan or Hong Kong. This project provides an alternative target: **Mainland Traditional Chinese** — the official traditional-character forms prescribed by the Chinese government for use in education, publishing, and formal writing on the mainland.

The reference standard is the *Table of General Standard Chinese Characters* (通用規範漢字表), published in 2013 by the People's Republic of China, covering 8,105 characters.

## Features

- Covers all 8,105 characters in the official standard
- One-way conversion: Simplified → Mainland Traditional
- Phrase-level and character-level dictionaries are kept separate to reduce mis-conversion
- Drop-in compatible with the OpenCC framework (CLI and library)

## Example

**Simplified input:**
> 忧郁的台湾雇佣龟弑杀僵尸后颓然惊叹：为什么凛凉窑洞中，虱子剥笋兑粽子，醋坛叙蕴喂了猫猪牦蚝，仿佛只为刹那亘古功勋？凄惨葱蝎荡项链秋千呐，杨幂同伙唇气叱咤如钩岳。

**Mainland Traditional output (this project):**
> 憂鬱的臺灣僱傭龜弑殺僵屍後頽然驚嘆：爲什麽凛凉窑洞中，虱子剥笋兑粽子，醋罎叙藴喂了猫猪牦蚝，仿佛衹爲刹那亘古功勛？凄慘葱蝎蕩項鏈鞦韆呐，楊幂同伙唇氣叱咤如鈎岳。

**Taiwan Traditional output (standard OpenCC `s2t`, for comparison):**
> 憂鬱的台灣僱傭龜弒殺殭屍後頹然驚歎：為什麼凜涼窯洞中，蝨子剝筍兌粽子，醋罈敘蘊餵了貓豬犛蠔，彷彿只為剎那亙古功勳？悽慘蔥蠍盪項鍊鞦韆吶，楊冪同夥脣氣叱吒如鉤嶽。

## Installation

**Linux (Debian/Ubuntu):**
```bash
sudo apt install opencc
```

**macOS:**
```bash
brew install opencc
```

## Usage

Clone this repository, then run OpenCC pointing at the bundled configuration:

```bash
git clone https://github.com/soizo/OpenCC-Mainland-Traditional-Chinese.git
cd OpenCC-Mainland-Traditional-Chinese

# Convert using plain-text dictionaries
opencc -i input.txt -o output.txt -c s2mt/s2mt.json

# Or use the pre-compiled binary dictionaries (faster)
opencc -i input.txt -o output.txt -c s2mt/ocd2/s2mt.json
```

To recompile the `.ocd2` binary dictionaries after editing the `.txt` source files:

```bash
cd s2mt
bash to_ocd2.sh
```

## Dictionary Files

| File | Lines | Description |
|------|-------|-------------|
| `s2mt/SMTCharacters.txt` | ~4,000 | Character-level mappings |
| `s2mt/SMTPhrases.txt` | ~49,000 | Phrase-level mappings |
| `s2mt/ocd2/SMTCharacters.ocd2` | — | Compiled character dictionary |
| `s2mt/ocd2/SMTPhrases.ocd2` | — | Compiled phrase dictionary |

## Status

- Character-level mappings: ongoing
- Phrase-level mappings: ongoing

## License

[Apache-2.0](LICENSE)
