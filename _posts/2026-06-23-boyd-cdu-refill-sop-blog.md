---
layout: post
title: "BOYD RAA32-10U21 CDU 補液 SOP"
date: 2026-06-23 08:00:00 +0800
categories:
  - SOP
  - LiquidCooling
lang: zh-TW
lang_ref: boyd-cdu-refill-sop    # 中英文共用的關聯 key
tags:
  - BOYD
  - CDU
  - Refill
  - DataCenter
excerpt: "BOYD RAA32-10U21 CDU 補液與排氣標準作業程序。"
---

# BOYD RAA32-10U21 CDU 補液 SOP

## 前言

本文說明 BOYD RAA32-10U21 CDU 系統之補液、排氣、壓力確認及雙幫浦備援驗證流程，確保液冷系統能正常運作並維持穩定壓力。

---

## 使用設備

- G4520G6 × 1
- BOYD RAA32-10U21 CDU × 1
- 外部冷卻液儲水桶
- 補水管線（進水與排氣各一條）
- 抹布
- 個人防護裝備（PPE）

---

## 安全注意事項

### EXHAUST PORT 殘壓風險

CDU 後方 EXHAUST PORT 可能存在系統殘壓。

為避免氣體釋放或冷卻液噴濺，請遵守以下原則：

> 先定位管路，再對接接口。

### 補液期間管線跳脫風險

補液時流體排出可能造成管線位移。

建議於集水桶孔徑處以抹布進行填塞固定，避免管線脫離容器。

---

## 系統配置

建立伺服器與 CDU 的 Secondary Liquid Cooling Loop（次級液冷迴路），形成完整閉環循環系統。

---

## 補液流程

### Step 1：確認電源

確認 CDU 電源已正確連接且供電正常。

### Step 2：安裝排氣管線

1. 移除 EXHAUST PORT 保護蓋。
2. 接上第一條快速接頭水管。
3. 將管線末端置於外部冷卻液儲水槽中。

### Step 3：安裝補液管線

1. 移除 COOLANT FILLING 保護蓋。
2. 接上第二條快速接頭水管。
3. 管線末端保持浸入儲水槽內。

### Step 4：確認接口

| 接口 | 說明 |
|------|------|
| INT | COOLANT FILLING（補水埠） |
| EXT | EXHAUST PORT（出水埠） |

系統將由外部儲液槽吸入冷卻液完成充填。

### Step 5：啟動補液幫浦

開啟 Refill Pump。

### Step 6：排除空氣

觀察 EXHAUST PORT 排出情況。

確認無氣泡後，可解除快速接頭鎖定但無需完全拔除。

### Step 7：完成補液

補液完成後，Refill Pump 將自動停止。

若系統原本已有冷卻液：

- 排氣時間約 3~5 分鐘
- 確認空氣已完全排除

### Step 8：啟動 CDU

啟動 CDU 系統。

### Step 9：確認回水壓力

監控 P2 Return Pressure。

#### 驗收標準

- P2 ≥ 130 kPa

#### 備註

系統啟動後 1~2 分鐘內可能出現暫態壓力下降。

請待系統穩定後再進行最終判定。

### Step 10：壓力不足處理

若壓力未達 130 kPa：

1. 關閉 CDU
2. 啟動 Refill Pump
3. 等待自動補液完成
4. 回到 Step 8

### Step 11：備援驗證

執行 Force Pump Switch。

確認雙幫浦備援切換功能正常。

### Step 12：關閉系統

關閉 CDU。

### Step 13：拆除管線

拆除：

- EXHAUST PORT 管線
- COOLANT FILLING 管線

若有殘液滲漏，立即擦拭。

### Step 14：回收殘液

抬高管線利用重力將殘液回流至儲水槽。

建議雙人作業執行。

### Step 15：收尾檢查

確認：

- 管線已滴乾
- 現場無殘留液體
- 裝置恢復原始狀態

---

## 驗收檢查表

| 檢查項目 | 完成 |
|----------|------|
| 補液完成 | ☐ |
| 排氣完成 | ☐ |
| P2 ≥ 130 kPa | ☐ |
| Force Pump Switch 驗證完成 | ☐ |
| 殘液清除完成 | ☐ |
| 現場整理完成 | ☐ |

---

## 結語

完成以上步驟後，即可確認 BOYD RAA32-10U21 CDU 液冷系統已完成補液、排氣及功能驗證，可投入正常運轉。
