---
layout: single
title: "如何使用 Redfish 命令远程升级 R2520G6 固件"
lang: zh-Hans
lang_ref: how-to-remotely-upgrade-r2520g6-firmware-using-redfish-commands
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
toc_label: "目录"
toc_sticky: true # fix right-side bar "Table of Contents"
---
本文提供使用 Redfish 命令远程升级 R2520G6 服务器固件的解决方案,解决手动或现场升级固件所面临的挑战。

## 概览

要在 R2520G6 上执行远程固件升级,请按照以下步骤使用 Redfish 命令操作:
1. **定义更新目标** — 使用 Redfish 的 PATCH 命令来指定要更新的组件。
2. **启动固件更新** — 使用 Redfish 的 POST 命令,针对先前定义的目标开始升级固件。
3. **准备固件文件** — 将 BIOS、BMC 和 ROT 固件文件上传至 Linux 工作目录,以供更新流程使用。
4. **关闭服务器电源** — 执行 Redfish 命令升级固件前,请确认 R2520G6 已关机。

> **注意:** 此流程需要带外(Out-of-Band, OOB)升级镜像文件。

---

## 所需固件文件

在开始之前,请将以下固件文件放置于 Linux 工作目录中:

| 组件 | 文件名格式 |
|---|---|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
| ROT | `B8066ROTAxx.xx_signed_cap_prd.bin` |

---

## BIOS 升级

### 步骤 1 — 检查当前版本

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bios_active
```

### 步骤 2 — 定义更新目标 (PATCH)

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

**预期响应:** `HTTP_CODE=200`

### 步骤 3 — 上传并应用固件 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**预期响应:** `HTTP_CODE=202`

### 结果

BMC 任务菜单中会出现一个任务。请等待约 **10 分钟** 让 BIOS 升级完成,然后重新执行步骤 1 以确认新版本。

---

## BMC 升级

### 步骤 1 — 检查当前版本

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bmc_active
```

### 步骤 2 — 定义更新目标 (PATCH)

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

**预期响应:** `HTTP_CODE=200`

### 步骤 3 — 上传并应用固件 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**预期响应:** `HTTP_CODE=202`

### 结果

BMC 任务菜单中会出现一个任务。请等待约 **20 分钟** 让 BMC 升级完成,然后重新执行步骤 1 以确认新版本。

---

## ROT 升级

### 步骤 1 — 检查当前版本

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/rot_fw_active
```

### 步骤 2 — 定义更新目标 (PATCH)

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

**预期响应:** `HTTP_CODE=200`

### 步骤 3 — 上传并应用固件 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**预期响应:** `HTTP_CODE=202`

### 结果

请等待约 **30 秒** 让 ROT 升级完成,然后重新执行步骤 1 以确认新版本。
