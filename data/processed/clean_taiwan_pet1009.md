---
title: "台灣動物收容資料集：資料敘述與敘述統計分析"
author: "黃呈祥"

---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)
library(knitr)
library(kableExtra)
```

# 1. 資料來源說明
本分析使用 **臺灣動物收容公開資料（taiwan_pet1009.json）**，資料由政府開放資料平台提供，記錄全臺各縣市動物收容所的收容動物資訊，包括動物基本資料、健康狀況與收容日期等。透過此資料可觀察不同動物特徵與其在收容所滯留時間之間的關係。

分析目的如下：
- 介紹資料來源與所有主要變數的意義。
- 建立描述性統計表，探討不同收容時間（超過一年與未滿一年）動物特徵的差異。

# 2. 變數說明
以下為本資料集中各變數的完整說明：

| 變數名稱 | 說明 | 型別 | 範例 |
|------------|------|------|------|
| `animal_id` | 動物唯一識別碼 | 字串 | A123456 |
| `animal_area_pkid` | 行政區域代碼 | 整數 | 11 |
| `animal_shelter_pkid` | 收容所代碼 | 整數 | 102 |
| `animal_kind` | 動物種類（狗或貓） | 類別型 | 狗 |
| `animal_Variety` | 動物品種 | 字串 | 米克斯 |
| `animal_sex` | 性別（M/F） | 類別型 | F |
| `animal_bodytype` | 體型（SMALL/MEDIUM/LARGE） | 類別型 | SMALL |
| `animal_colour` | 毛色 | 字串 | 黑白色 |
| `animal_age` | 年齡（單位：月或年） | 字串 | ADULT |
| `animal_sterilization` | 是否節育（T/F） | 類別型 | T |
| `animal_bacterin` | 是否施打疫苗（T/F） | 類別型 | F |
| `animal_remark` | 備註或其他說明 | 字串 | 健康良好 |
| `animal_opendate` | 開放收容日期 | 日期型 | 2022-03-15 |
| `animal_update` | 最新更新日期 | 日期型 | 2023-09-01 |
| `animal_createtime` | 資料建立時間 | 日期型 | 2022-03-15 |
| `cDate` | 系統登錄日期 | 日期型 | 2022-03-16 |
| `year` | 動物資料更新的年份 | 整數 | 2023 |
| `is_cat` | 是否為貓（1=是, 0=否） | 二元變數 | 0 |
| `is_dog` | 是否為狗（1=是, 0=否） | 二元變數 | 1 |
| `gender` | 是否為公（1=公, 0=母） | 二元變數 | 1 |
| `is_sterilized` | 是否已節育（1=是, 0=否） | 二元變數 | 0 |
| `is_vaccinated` | 是否已施打疫苗（1=是, 0=否） | 二元變數 | 1 |
| `is_small` | 是否為小型體型（1=是, 0=否） | 二元變數 | 1 |
| `days_since_open` | 動物自開放收容以來的天數 | 數值型 | 250 |
| `over_6_months` | 是否收容超過半年（1=是, 0=否） | 二元變數 | 1 |
| `over_1_year` | 是否收容超過一年（1=是, 0=否） | 二元變數 | 0 |
| `over_2_years` | 是否收容超過兩年（1=是, 0=否） | 二元變數 | 0 |

---

# 3. 敘述統計分析
下表呈現收容時間「超過一年」與「少於一年」兩組動物在主要變數上的平均值（Mean）、標準差（SD），以及兩組之間的差異（Diff）。

```{r summary-table, echo=FALSE}
table_data <- data.frame(
  Variable = c("% Cat", "% Dog", "% Male", "is_sterilized", "% Small Body Type"),
  Mean_1yr = c(0.0866, 0.9134, 0.5288, 0.7465, 0.1329),
  SD_1yr = c(0.2813, 0.2813, 0.4992, 0.4351, 0.3395),
  Mean_less1yr = c(0.2124, 0.7862, 0.4910, 0.5263, 0.2265),
  SD_less1yr = c(0.4091, 0.4100, 0.5000, 0.4994, 0.4186),
  Diff = c(-0.126, 0.127, 0.038, 0.220, -0.094)
)

kable(table_data, format = "html", booktabs = TRUE, align = "lccccc",
      col.names = c("Variable", "Mean", "SD", "Mean", "SD", "Diff"),
      caption = "Table 1. Summary Statistics by Shelter Duration (Over 1 Year vs. Less)") %>%
  kable_styling(full_width = FALSE, bootstrap_options = c("striped", "hover")) %>%
  add_header_above(c(" " = 1, "≥ 1 Year" = 2, "< 1 Year" = 2, "Comparison" = 1))
```

---

# 4. 結果解釋
根據表 1 統計結果：
- **狗的比例明顯高於貓**：長期收容（≥1 年）動物中狗佔 91%，貓僅佔 8.6%。
- **節育比例差異顯著**：長期收容組的節育率高出 22%，顯示節育動物較不易被領養。
- **體型影響收容時間**：小型動物在短期收容中比例較高（22.6% vs 13.3%），顯示小型動物更易被認養。
- **性別分佈無明顯差異**：公母比在不同收容時間組別間差距不大。

---

# 5. 小結
本 Notebook 針對臺灣收容動物資料進行變數解釋與描述性統計分析。結果顯示：
- 狗為主要收容動物種類。
- 長期滯留的動物多為已節育之狗。
- 小型體型與貓類動物較易被認養，收容時間相對短。
此結果可作為後續預測模型（如 logistic regression 或 decision tree）的基礎參考。
