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

This article provides a solution for remotely upgrading the firmware of the R2520G6 server using Redfish commands, addressing challenges associated with manual or onsite firmware updates.

## Overview

To perform a remote firmware upgrade on the R2520G6, follow these steps using Redfish commands:

1. **Define Update Targets** — Use PATCH commands with Redfish to specify the components you wish to update.
2. **Initiate Firmware Update** — Use POST commands with Redfish to begin upgrading the firmware on the previously defined targets.
3. **Prepare Firmware Files** — Upload the BIOS, BMC, CPLD, and ROT firmware files to the Linux working directory for the update process.
4. **Power Off the Server** — Ensure that the R2520G6 is powered off before executing Redfish commands to upgrade the firmware.

> **Note:** This process requires out-of-band (OOB) upgrade image files.

### Required Firmware Files

| Component | Filename Pattern |
|-----------|-----------------|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
| CPLD | `E7142_HPM_SCM_Rxx_Vxxx_prd_sign.bin` |
| ROT | `B8066ROTAxx.xx_signed_cap_prd.bin` |

---

## BIOS Upgrade Process

### 1. Check Current BIOS Firmware Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bios_active
```

### 2. Define Update Target (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": {
        "ApplyTime": "Immediate"
      }
    },
    "HttpPushUriTargets": ["bios_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": {
      "ApplyOptions": {
        "ClearConfig": true
      }
    }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=200`

### 3. Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### 4. Monitor and Verify

- A task will appear in the BMC Task menu.
- Wait approximately **10 minutes** for the BIOS upgrade process to complete.
- Re-run the version check command from Step 1 to confirm the upgrade.

---

## BMC Upgrade Process

### 1. Check Current BMC Firmware Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bmc_active
```

### 2. Define Update Target (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": {
        "ApplyTime": "Immediate"
      }
    },
    "HttpPushUriTargets": ["bmc_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": {
      "ApplyOptions": {
        "ClearConfig": false
      }
    }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=200`

### 3. Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### 4. Monitor and Verify

- A task will appear in the BMC Task menu.
- Wait approximately **20 minutes** for the BMC upgrade process to complete.
- Re-run the version check command from Step 1 to confirm the upgrade.

---

## CPLD Upgrade Process

### 1. Check Current CPLD Firmware Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/cpld_active
```

### 2. Define Update Target (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": {
        "ApplyTime": "Immediate"
      }
    },
    "HttpPushUriTargets": ["cpld_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": {
      "ApplyOptions": {
        "ClearConfig": false
      }
    }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=200`

### 3. Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### 4. Monitor and Verify

- Wait approximately **30 seconds** for the CPLD upgrade process to complete.
- Re-run the version check command from Step 1 to confirm the upgrade.

---

## ROT Upgrade Process

### 1. Check Current ROT Firmware Version

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/rot_fw_active
```

### 2. Define Update Target (PATCH)

```bash
curl -k -u username:password -X PATCH \
  https://{BMC_IP}/redfish/v1/UpdateService \
  -H "Content-Type: application/json" \
  -d '{
    "HttpPushUriOptions": {
      "HttpPushUriApplyTime": {
        "ApplyTime": "Immediate"
      }
    },
    "HttpPushUriTargets": ["rot_fw_active"],
    "HttpPushUriTargetsBusy": true,
    "Oem": {
      "ApplyOptions": {
        "ClearConfig": false
      }
    }
  }' \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=200`

### 3. Upload and Apply Firmware (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**Expected Response:** `HTTP_CODE=202`

### 4. Monitor and Verify

- Wait approximately **30 seconds** for the ROT upgrade process to complete.
- Re-run the version check command from Step 1 to confirm the upgrade.
