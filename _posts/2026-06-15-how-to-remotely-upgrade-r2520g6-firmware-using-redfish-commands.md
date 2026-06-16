---
layout: single
title: "How to Remotely Upgrade R2520G6 Firmware Using Redfish Commands"
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
  - CPLD
  - ROT
author_profile: true
read_time: true
share: true
related: true
toc: true
toc_label: "Table of Contents"
---

## Question

How to remotely upgrade the firmware of the R2520G6 server using Redfish commands?

## Answer

Use Redfish `PATCH` and `POST` commands from a Linux host to define update targets and upload firmware images for each component. Ensure the R2520G6 is powered off and that out-of-band (OOB) upgrade image files are prepared before starting.

> **Note:** This process requires out-of-band (OOB) upgrade image files.

---

## Required Firmware Files

Place the following firmware files in your Linux working directory before proceeding:

| Component | Filename Pattern |
|---|---|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
| CPLD | `E7142_HPM_SCM_Rxx_Vxxx_prd_sign.bin` |
| ROT | `B8066ROTAxx.xx_signed_cap_prd.bin` |

---

## BIOS Upgrade

### Step 1 — Check Current Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bios_active
```

### Step 2 — Define Update Target (PATCH)

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

**Expected Response:** `HTTP_CODE=200`

### Step 3 — Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### Result

A task will appear in the BMC Task menu. Wait approximately **10 minutes** for the BIOS upgrade to complete, then re-run Step 1 to confirm the new version.

---

## BMC Upgrade

### Step 1 — Check Current Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bmc_active
```

### Step 2 — Define Update Target (PATCH)

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

**Expected Response:** `HTTP_CODE=200`

### Step 3 — Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### Result

A task will appear in the BMC Task menu. Wait approximately **20 minutes** for the BMC upgrade to complete, then re-run Step 1 to confirm the new version.

---

## CPLD Upgrade

### Step 1 — Check Current Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/cpld_active
```

### Step 2 — Define Update Target (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": { "ApplyTime": "Immediate" }
    },
    "HttpPushUriTargets": ["cpld_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": { "ApplyOptions": { "ClearConfig": false } }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=200`

### Step 3 — Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### Result

Wait approximately **30 seconds** for the CPLD upgrade to complete, then re-run Step 1 to confirm the new version.

---

## ROT Upgrade

### Step 1 — Check Current Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/rot_fw_active
```

### Step 2 — Define Update Target (PATCH)

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

**Expected Response:** `HTTP_CODE=200`

### Step 3 — Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### Result

Wait approximately **30 seconds** for the ROT upgrade to complete, then re-run Step 1 to confirm the new version.
