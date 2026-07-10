---
layout: single
title: "How to Remotely Upgrade R2520G6 Firmware Using Redfish Commands"
date: 2026-06-15 00:00:00 +0800
lang: en
lang_ref: how-to-remotely-upgrade-r2520g6-firmware-using-redfish-commands
Description: "This article provides a solution for remotely upgrading the firmware of the R2520G6 server using Redfish commands, addressing challenges associated with manual or onsite firmware updates."
categories:
  - Redfish
  - Firmware
  - How to
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
toc_label: "Table of Contents"
toc_sticky: true # fix right-side bar "Table of Contents"
---
This article provides a solution for remotely upgrading the firmware of the R2520G6 server using Redfish commands, addressing challenges associated with manual or onsite firmware updates.

## Overview

To perform a remote firmware upgrade on the R2520G6, follow these steps using Redfish commands:
1. **Define Update Targets** — Use PATCH commands with Redfish to specify the components you wish to update.
2. **Initiate Firmware Update** — Use POST commands with Redfish to begin upgrading the firmware on the previously defined targets.
3. **Prepare Firmware Files** — Upload the BIOS, BMC and ROT firmware files to the Linux working directory for the update process.
4. **Power Off the Server** — Ensure that the R2520G6 is powered off before executing Redfish commands to upgrade the firmware.

> **Note:** This process requires out-of-band (OOB) upgrade image files.

---

## Required Firmware Files

Place the following firmware files in your Linux working directory before proceeding:

| Component | Filename Pattern |
|---|---|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
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
