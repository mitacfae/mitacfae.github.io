---
title: "BOYD RAA32-10U21 CDU補液SOP"
excerpt: "BOYD RAA32-10U21 CDU 補液、排氣與雙幫浦備援驗證之標準作業程序。"
date: 2026-06-24
lang: zh-TW
lang_ref: boyd-cdu-refill-sop
categories:
  - sop
  - liquidcooling
tags:
  - CDU
  - BOYD
  - 液冷
  - SOP
header:
  teaser: https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg
---

本文說明 BOYD RAA32-10U21 CDU 補液、排氣，以及雙幫浦備援切換驗證之標準作業程序，確保液冷迴路能在穩定壓力下正常運作。

## 概述

執行 BOYD RAA32-10U21 CDU 補液與啟用作業時，請依下列步驟進行：

1. **接上補水與排氣管線** — 將管線分別接至 CDU 的 `COOLANT FILLING` 與 `EXHAUST PORT` 接口，兩條管線末端皆需浸入外部冷卻液儲水槽中。
2. **啟動補水幫浦** — 自外部儲水槽吸入冷卻液並排除迴路中的空氣。
3. **啟動 CDU 並確認壓力** — 確認次級迴路回水壓力（P2）達到驗收標準。
4. **驗證幫浦備援** — 執行強制幫浦切換，確認雙幫浦備援切換機制正常運作。

> **注意：** CDU 運轉後，`EXHAUST PORT` 接口可能仍存在殘壓。務必先定位管路，再對接接口，以避免氣體釋放或冷卻液噴濺。

---

## 使用設備清單

| 項目 | 數量 |
| --- | --- |
| G4520G6 伺服器 | 1 |
| BOYD RAA32-10U21 CDU | 1 |
| 外部冷卻液儲水桶 | 1 |
| 補水管線（進水＋排氣） | 2 |
| 抹布 | 1 條以上 |
| 個人防護裝備（PPE） | 依需求 |

---

## 安全注意事項

### EXHAUST PORT 殘壓風險

CDU 後方的 `EXHAUST PORT` 接口可能存在系統殘壓。

為避免接口時發生氣體釋放或流體噴濺：
> 務必先定位管路，再對接接口，不可顛倒順序。

### 補液期間管線跳脫風險

執行補液作業時，流體排出之動能衝擊可能導致補水管線跳脫容器。

請於儲水桶孔徑處以抹布緊密填塞，避免管線脫離容器。

### 系統配置

將伺服器端與 CDU 建立完整的次級液冷迴路（Secondary Liquid Cooling Loop），形成閉合循環系統。

---

## 補液流程

### Step 1 — 確認電源

CDU 電源接好並確認電力供應正常。

### Step 2 — 接上排氣管線

移除 CDU 後側 `EXHAUST PORT` 黑色外蓋，並接上第一條快速接頭水管。管線末端須全程置於外部冷卻液儲水槽中，以避免冷卻液外漏。

![BOYD RAA32-10U21 CDU 後方 EXHAUST PORT 接口](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg)

### Step 3 — 接上補水管線

移除 CDU 後側 `COOLANT FILLING` 黑色外蓋，並接上第二條快速接頭水管。管線末端同樣須全程置於外部冷卻液儲水槽中。

![BOYD RAA32-10U21 CDU 後方 COOLANT FILLING 接口](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/coolant-filling-port.jpeg)

### Step 4 — 確認接口定義

| 接口 | 說明 |
| --- | --- |
| `INT` | 系統補水埠（`COOLANT FILLING`） |
| `EXT` | 系統出水埠（`EXHAUST PORT`） |

系統運轉時，將自外部容器主動吸入冷卻液以進行系統充液。

![CDU 與外部冷卻液儲水槽之 INT / EXT 管線連接示意圖](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/int-ext-connection.png)

### Step 5 — 啟動補水幫浦

於 CDU 觸控面板開啟 **Refill Pump**。

![CDU Operating Setpoint 畫面之 Refill Pump ON/OFF 開關](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/refill-pump-onoff.jpeg)

### Step 6 — 排除空氣

觀察 `EXHAUST PORT` 是否仍有氣泡排出。確認無氣泡後，將快速接頭解除鎖定，但無需完全拔除。

### Step 7 — 完成補液

補水泵會在完成充液後自行停止運作。

若伺服器與 CDU 內部先前已預填冷卻液：
- 排氣與補水程序大約耗時 **3 至 5 分鐘**
- 請目視確認夾帶空氣已完全排出

### Step 8 — 啟動 CDU

啟動 CDU。

### Step 9 — 確認回水壓力

監測系統狀態畫面之 **Return Pressure（P2）**。

![CDU System Status 畫面之 Return Press P2 數值](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/return-pressure-p2.jpeg)

#### 驗收標準

- P2 ≥ 130 kPa

#### 備註

開機初期運轉約 1～2 分鐘內，數值可能出現暫態下降。請等待系統穩定後，再進行最終判定。

### Step 10 — 壓力未達標處理

若 P2 未達 130 kPa，請執行以下步驟：

1. 關閉 CDU
2. 啟動 Refill Pump
3. 等待自動補水完成
4. 回到 Step 8

### Step 11 — 驗證幫浦備援

執行 **Force Pump Switch**，確認雙幫浦備援切換機制正常運作。

![CDU Operating Setpoint 畫面之 Force Pump Switch 控制項](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/force-pump-switch.jpeg)

### Step 12 — 關閉系統

關閉 CDU。

### Step 13 — 拆除管線

拆卸 `EXHAUST PORT` 與 `COOLANT FILLING` 兩條補水管線。解除快速接頭時可能伴隨微量殘液溢漏，如有洩漏請立即以抹布擦乾。

### Step 14 — 回收殘液

管線接頭脫開後，抬高管線利用重力將殘液流回儲水槽，並注意管線末端不脫離儲水槽。建議全程採雙人協同作業，以確保安全。

### Step 15 — 收尾檢查

確認：
- 管線已完全滴乾
- 現場無殘留液體
- 裝置已恢復原始狀態

---

## 驗收檢查表

| 檢查項目 | 完成 |
| --- | --- |
| 補液完成 | ☐ |
| 排氣完成 | ☐ |
| P2 ≥ 130 kPa | ☐ |
| Force Pump Switch 驗證完成 | ☐ |
| 殘液清除完成 | ☐ |
| 現場整理完成 | ☐ |

---

## 結語

完成以上步驟後，即可確認 BOYD RAA32-10U21 CDU 液冷迴路已完成補液、排氣及功能驗證，可投入正常運轉。
