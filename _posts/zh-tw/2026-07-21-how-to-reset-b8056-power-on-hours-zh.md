---
title: "如何重置 B8056 開機時數 (Power-On Hours)"
excerpt: "本文說明如何透過 Linux 腳本呼叫 ipmitool 指令，重置 B8056 平台的 Power-On Hours (POH) 計數器。"
categories:
  - BMC
  - IPMI
  - How to
tags:
  - BMC
  - IPMI
  - ipmitool
  - Power-On Hours
  - B8056
lang: zh-TW
lang_ref: how-to-reset-b8056-power-on-hours
toc: true
toc_label: "目錄"
toc_sticky: true
header:
  teaser: /assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png
---

本文說明如何重置 B8056 平台的 **Power-On Hours (POH)** 開機時數計數器。POH 數值可以透過在 Linux 主機端執行一個包裝腳本來清除，該腳本底層會呼叫 `ipmitool` 指令送到 BMC。

## 概述

B8056 的 Power-On Hours 計數器可以透過一個 Linux shell 腳本重置，該腳本內部呼叫 `ipmitool`。這在更換主機板、老化測試（burn-in）後，或任何需要在系統出貨、重新上線前清除累積 POH 數值的情境下都很實用。

![重置前 BMC 顯示的 Power-On Hours 數值](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png)

---

## 事前準備

| 項目       | 需求                                       |
| ---------- | ------------------------------------------ |
| 工具       | `8056_clear_poh.sh` 腳本（包裝 `ipmitool`）|
| 網路連線   | 可連線到的 BMC IP 位址                     |
| 帳號密碼   | 有效的 BMC 使用者名稱與密碼                 |
| 執行環境   | 已安裝 `ipmitool` 的 Linux 主機             |

---

## 操作步驟

### 指令

在 Linux 環境中執行腳本，並帶入 BMC 使用者名稱、BMC 密碼與 BMC IP 位址作為參數：

```
./8056_clear_poh.sh {BMC_username} {BMC_password} {BMC_IP_Address}
```

請將 `{BMC_username}`、`{BMC_password}`、`{BMC_IP_Address}` 替換成目標系統的實際數值。

### 範例

```
$ ./8056_clear_poh.sh root tyan@123 10.99.238.73
```

![對目標 BMC 執行 POH 清除腳本的範例](/assets/images/bmc/how-to-reset-b8056-power-on-hours/script-execution-example.png)

[Download 8056_clear_poh.sh](/assets/files/bmc/how-to-reset-b8056-power-on-hours/8056_clear_poh.sh)

### 執行結果

腳本執行完成後，Power-On Hours 計數器會被清除，重新讀取時會顯示已重置。

![執行腳本後確認 Power-On Hours 已重置](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-after-reset.png)

---

## 重置後

請透過 BMC 網頁介面或 `ipmitool` 再次確認 POH 數值，確保它已歸零（或符合預期的基準值），再將系統交回使用。

> **注意：** 此操作僅會清除累積的 Power-On Hours 計數器，不會影響 BMC 的網路設定、使用者帳號或其他感測器紀錄。
