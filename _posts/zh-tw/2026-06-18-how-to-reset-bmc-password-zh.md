---
layout: single
title: "如何重設 BMC 密碼"
date: 2026-06-18 00:00:00 +0800
lang: zh-TW
lang_ref: how-to-reset-bmc-password
categories:
  - IPMI
  - BMC
tags:
  - BMC
  - IPMI
  - ipmitool
  - Password
  - Security
author_profile: true
read_time: true
share: true
related: true
comments: true
toc: true
toc_label: "目錄"
toc_sticky: true
---

本文說明如何使用 `ipmitool` 重設 BMC 密碼，涵蓋兩種情境：遠端重設（仍可透過網路連線至 BMC）以及本機重設（BMC 密碼未知或遺失時）。

## 概述

重設 BMC 密碼有兩種情境：

1. **遠端重設** — 您仍擁有有效的 BMC 帳號密碼與網路連線，可透過 LAN 使用 `ipmitool` 遠端觸發密碼重設。
2. **本機重設** — BMC 密碼未知或遺失時，必須直接在本機主機上（in-band）執行 `ipmitool`，無需帳號密碼即可重設。

> **注意：** 無論採用哪一種重設方式，BMC 都會自動重新啟動。重啟後，您需要使用 **BMC 預設密碼** 才能登入。

---

## 事前準備

| 項目 | 需求 |
|---|---|
| 工具 | 已安裝 `ipmitool` |
| 遠端重設 | 具備連線至 BMC IP 的網路，以及有效的帳號密碼 |
| 本機重設 | 具備伺服器作業系統的實體或主控台存取權限 |

---

## 情境一：遠端重設

當您仍擁有有效的 BMC 帳號密碼與網路連線時，可使用此方法。

### 指令

```bash
ipmitool -H {BMC_IP} -U {BMC_username} -P {BMC_password} raw 0x32 0x66
```

請將 `{BMC_IP}`、`{BMC_username}` 及 `{BMC_password}` 替換為實際數值。

### 範例

```bash
ipmitool -H 192.168.1.100 -U admin -P current_password raw 0x32 0x66
```

### 結果

BMC 將自動重新啟動。重啟後，請使用 **BMC 預設密碼** 登入。

---

## 情境二：本機重設（密碼遺失）

當 BMC 密碼未知或遺失，且無法透過遠端存取時，可使用此方法。

### 指令

直接在伺服器上執行以下指令（in-band 方式，不需要 IP 或帳號密碼）：

```bash
ipmitool raw 0x32 0x66
```

### 結果

BMC 將自動重新啟動。重啟後，請使用 **BMC 預設密碼** 登入。

---

## 重設後的步驟

BMC 重新啟動後，請使用出廠預設帳號密碼登入。預設的使用者名稱與密碼通常印製於伺服器的服務標籤（service label）上，或記載於該平台的硬體使用手冊中。

> 建議在使用預設帳號密碼登入後，立即變更 BMC 密碼。
