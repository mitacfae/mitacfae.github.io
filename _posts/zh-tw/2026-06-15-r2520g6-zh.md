---
layout: single
title: "如何使用 Redfish 指令遠端升級 R2520G6 韌體"
lang: zh-TW
lang_ref: how-to-remotely-upgrade-r2520g6-firmware-using-redfish-commands
permalink: /zh/redfish/firmware/how-to-remotely-upgrade-r2520g6-firmware-using-redfish-commands/
date: 2026-06-15 00:00:00 +0800
categories:
  - Redfish
  - Firmware
tags:
  - R2520G6
  - Redfish
  - Firmware
  - BMC
  - BIOS
  - ROT
author_profile: true
read_time: true
share: true
related: true
toc: true
toc_label: "目錄"
toc_sticky: true # fix right-side bar "Table of Contents"
---
本文提供使用 Redfish 指令遠端升級 R2520G6 伺服器韌體的解決方案,解決手動或現場升級韌體所面臨的挑戰。

## 概觀

若要在 R2520G6 上執行遠端韌體升級,請依照以下步驟使用 Redfish 指令操作:
1. **定義更新目標** — 使用 Redfish 的 PATCH 指令來指定要更新的元件。
2. **啟動韌體更新** — 使用 Redfish 的 POST 指令,針對先前定義的目標開始升級韌體。
3. **準備韌體檔案** — 將 BIOS、BMC 與 ROT 韌體檔案上傳至 Linux 工作目錄,以供更新程序使用。
4. **關閉伺服器電源** — 執行 Redfish 指令升級韌體前,請確認 R2520G6 已關機。

> **注意:** 此流程需要頻外(Out-of-Band, OOB)升級映像檔案。

---

## 所需韌體檔案

在開始之前,請將以下韌體檔案放置於 Linux 工作目錄中:

| 元件 | 檔名格式 |
|---|---|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
| ROT | `B8066ROTAxx.xx_signed_cap_prd.bin` |

---

## BIOS 升級

### 步驟 1 — 檢查目前版本

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bios_active
```

### 步驟 2 — 定義更新目標 (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": { "ApplyTime": "Immediate" }
    },
    "HttpPushUriTargets": ["bios_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": { "ApplyOptions": { "ClearConfig": true } }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**預期回應:** `HTTP_CODE=200`

### 步驟 3 — 上傳並套用韌體 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**預期回應:** `HTTP_CODE=202`

### 結果

BMC 工作項目選單中會出現一個任務。請等待約 **10 分鐘** 讓 BIOS 升級完成,接著重新執行步驟 1 以確認新版本。

---

## BMC 升級

### 步驟 1 — 檢查目前版本

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bmc_active
```

### 步驟 2 — 定義更新目標 (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": { "ApplyTime": "Immediate" }
    },
    "HttpPushUriTargets": ["bmc_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": { "ApplyOptions": { "ClearConfig": false } }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**預期回應:** `HTTP_CODE=200`

### 步驟 3 — 上傳並套用韌體 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**預期回應:** `HTTP_CODE=202`

### 結果

BMC 工作項目選單中會出現一個任務。請等待約 **20 分鐘** 讓 BMC 升級完成,接著重新執行步驟 1 以確認新版本。

---

## ROT 升級

### 步驟 1 — 檢查目前版本

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/rot_fw_active
```

### 步驟 2 — 定義更新目標 (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": { "ApplyTime": "Immediate" }
    },
    "HttpPushUriTargets": ["rot_fw_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": { "ApplyOptions": { "ClearConfig": false } }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**預期回應:** `HTTP_CODE=200`

### 步驟 3 — 上傳並套用韌體 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**預期回應:** `HTTP_CODE=202`

### 結果

請等待約 **30 秒** 讓 ROT 升級完成,接著重新執行步驟 1 以確認新版本。
