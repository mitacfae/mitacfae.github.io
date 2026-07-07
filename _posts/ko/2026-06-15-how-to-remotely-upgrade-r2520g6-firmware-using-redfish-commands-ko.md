---
layout: single
title: "Redfish 명령어를 사용하여 R2520G6 펌웨어 원격 업그레이드하는 방법"
lang: ko
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
toc_label: "목차"
toc_sticky: true # fix right-side bar "Table of Contents"
---
이 문서에서는 Redfish 명령어를 사용하여 R2520G6 서버의 펌웨어를 원격으로 업그레이드하는 방법을 소개하며, 수동 또는 현장 방문 펌웨어 업데이트에 따르는 어려움을 해결합니다.

## 개요

R2520G6에서 원격 펌웨어 업그레이드를 수행하려면 Redfish 명령어를 사용하여 다음 단계를 따르세요.
1. **업데이트 대상 정의** — Redfish의 PATCH 명령어를 사용하여 업데이트하려는 구성 요소를 지정합니다.
2. **펌웨어 업데이트 시작** — Redfish의 POST 명령어를 사용하여 앞서 정의한 대상에 대해 펌웨어 업그레이드를 시작합니다.
3. **펌웨어 파일 준비** — 업데이트 과정을 위해 BIOS, BMC, ROT 펌웨어 파일을 Linux 작업 디렉터리에 업로드합니다.
4. **서버 전원 끄기** — Redfish 명령어를 실행하여 펌웨어를 업그레이드하기 전에 R2520G6의 전원이 꺼져 있는지 확인합니다.

> **참고:** 이 절차에는 대역외(Out-of-Band, OOB) 업그레이드 이미지 파일이 필요합니다.

---

## 필요한 펌웨어 파일

시작하기 전에 다음 펌웨어 파일을 Linux 작업 디렉터리에 배치하세요.

| 구성 요소 | 파일명 패턴 |
|---|---|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
| ROT | `B8066ROTAxx.xx_signed_cap_prd.bin` |

---

## BIOS 업그레이드

### 단계 1 — 현재 버전 확인

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bios_active
```

### 단계 2 — 업데이트 대상 정의 (PATCH)

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

**예상 응답:** `HTTP_CODE=200`

### 단계 3 — 펌웨어 업로드 및 적용 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**예상 응답:** `HTTP_CODE=202`

### 결과

BMC 작업 메뉴에 작업이 표시됩니다. BIOS 업그레이드가 완료될 때까지 약 **10분** 정도 기다린 후, 단계 1을 다시 실행하여 새 버전을 확인하세요.

---

## BMC 업그레이드

### 단계 1 — 현재 버전 확인

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bmc_active
```

### 단계 2 — 업데이트 대상 정의 (PATCH)

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

**예상 응답:** `HTTP_CODE=200`

### 단계 3 — 펌웨어 업로드 및 적용 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**예상 응답:** `HTTP_CODE=202`

### 결과

BMC 작업 메뉴에 작업이 표시됩니다. BMC 업그레이드가 완료될 때까지 약 **20분** 정도 기다린 후, 단계 1을 다시 실행하여 새 버전을 확인하세요.

---

## ROT 업그레이드

### 단계 1 — 현재 버전 확인

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/rot_fw_active
```

### 단계 2 — 업데이트 대상 정의 (PATCH)

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

**예상 응답:** `HTTP_CODE=200`

### 단계 3 — 펌웨어 업로드 및 적용 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**예상 응답:** `HTTP_CODE=202`

### 결과

ROT 업그레이드가 완료될 때까지 약 **30초** 정도 기다린 후, 단계 1을 다시 실행하여 새 버전을 확인하세요.
