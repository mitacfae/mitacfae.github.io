---
layout: single
title: "如何停用 B8016 CPU iGPU 功能"
lang: zh-TW
lang_ref: how-to-disable-b8016-cpu-igpu
date: 2026-06-15 00:00:00 +0800
categories:
  - BIOS
  - Hardware
tags:
  - B8016
  - iGPU
  - AMD
  - BIOS
  - Windows Server
author_profile: true
read_time: true
share: true
related: true
toc: true
toc_label: "目錄"
---

本文提供透過 BIOS 設定停用 B8016 平台 CPU 內建顯示卡(iGPU)的解決方案,適用於需要從作業系統裝置管理員中移除 AMD Radeon Graphics 裝置的情境。

## 概觀

若要停用 B8016 上的 iGPU,請依照以下步驟操作:

1. **更新 BIOS** — 進行變更前,請確認 B8016 已更新至 BIOS **v9.00 (0x30)** 或更新版本。
2. **進入 GFX Configuration** — 在 BIOS 的 AMD CBS 選單中進入 iGPU 相關設定。
3. **套用所需設定** — 停用 dGPU Only Mode、iGPU Configuration 與 GPU Host Translation Cache。
4. **儲存並重新開機** — 儲存 BIOS 變更並重新開機以套用設定。

> **注意:** 套用這些設定後,Windows Server 2025 裝置管理員中的 **「AMD Radeon Graphics」將會消失**。

---

## 先決條件

| 項目 | 需求 |
|---|---|
| BIOS 版本 | v9.00 (0x30) 或更新版本 |
| 作業系統 | Windows Server 2025 |
| 所需存取權限 | 對 BIOS 的實體或遠端 KVM 存取權限 |

---

## BIOS 設定

### 1. 進入 BIOS 設定畫面

開機或重新啟動 B8016,並在 POST 過程中按下對應按鍵以進入 BIOS 設定畫面。

### 2. 進入 GFX Configuration

```
Advanced → AMD CBS → NBIO Common Options → GFX Configuration
```

### 3. 套用所需設定

將下列三項設定由預設值改為:

| 設定項目 | 由 | 改為 |
|---|---|---|
| dGPU Only Mode | `[Auto]` | `[Disabled]` |
| iGPU Configuration | `[Auto]` | `[iGPU Disabled]` |
| GPU Host Translation Cache | `[Auto]` | `[Disabled]` |

![顯示所需設定的 BIOS GFX Configuration 畫面](/assets/images/2026-06-15-b8016-igpu/image1.png)

### 4. 儲存並重新開機

按下 **F10**(或選擇 Save & Exit 選項)以儲存變更並重新開機。

---

## 驗證

系統重新開機後,開啟 Windows Server 2025 的 **裝置管理員**,並在 **顯示卡** 項目下確認結果。

### 變更前

裝置管理員的顯示卡清單中會列出 AMD Radeon(TM) Graphics。

![變更前的裝置管理員:顯示卡下可見 AMD Radeon(TM) Graphics](/assets/images/2026-06-15-b8016-igpu/image2.png)

### 變更後

裝置管理員中不再出現 AMD Radeon(TM) Graphics,僅剩下 **Microsoft 基本顯示介面卡**。

![變更後的裝置管理員:顯示卡下的 AMD Radeon(TM) Graphics 已移除](/assets/images/2026-06-15-b8016-igpu/image3.png)
