---
layout: single
title: "Redfish コマンドを使用した R2520G6 ファームウェアのリモートアップグレード方法"
lang: ja
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
toc_label: "目次"
toc_sticky: true # fix right-side bar "Table of Contents"
---
本記事では、Redfish コマンドを使用して R2520G6 サーバーのファームウェアをリモートでアップグレードする方法を紹介します。手動またはオンサイトでのファームウェア更新に伴う課題を解決します。

## 概要

R2520G6 でリモートファームウェアアップグレードを実行するには、Redfish コマンドを使用して以下の手順に従います。
1. **更新対象の定義** — Redfish の PATCH コマンドを使用して、更新したいコンポーネントを指定します。
2. **ファームウェア更新の開始** — Redfish の POST コマンドを使用して、先に定義した対象のファームウェアアップグレードを開始します。
3. **ファームウェアファイルの準備** — BIOS、BMC、ROT のファームウェアファイルを Linux 作業ディレクトリにアップロードし、更新処理に備えます。
4. **サーバーの電源オフ** — Redfish コマンドを実行してファームウェアをアップグレードする前に、R2520G6 の電源がオフになっていることを確認します。

> **注意:** この手順にはアウトオブバンド(OOB)アップグレードイメージファイルが必要です。

---

## 必要なファームウェアファイル

作業を開始する前に、以下のファームウェアファイルを Linux 作業ディレクトリに配置してください。

| コンポーネント | ファイル名パターン |
|---|---|
| BIOS | `B066xxxxxx_signed_cap_prd.bin` |
| BMC | `B066Axxx.Ixx_signed_cap_prd.bin` |
| ROT | `B8066ROTAxx.xx_signed_cap_prd.bin` |

---

## BIOS アップグレード

### 手順 1 — 現在のバージョンを確認

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bios_active
```

### 手順 2 — 更新対象を定義 (PATCH)

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

**期待されるレスポンス:** `HTTP_CODE=200`

### 手順 3 — ファームウェアのアップロードと適用 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**期待されるレスポンス:** `HTTP_CODE=202`

### 結果

BMC のタスクメニューにタスクが表示されます。BIOS のアップグレードが完了するまで約 **10 分** 待ってから、手順 1 を再実行して新しいバージョンを確認してください。

---

## BMC アップグレード

### 手順 1 — 現在のバージョンを確認

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/bmc_active
```

### 手順 2 — 更新対象を定義 (PATCH)

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

**期待されるレスポンス:** `HTTP_CODE=200`

### 手順 3 — ファームウェアのアップロードと適用 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**期待されるレスポンス:** `HTTP_CODE=202`

### 結果

BMC のタスクメニューにタスクが表示されます。BMC のアップグレードが完了するまで約 **20 分** 待ってから、手順 1 を再実行して新しいバージョンを確認してください。

---

## ROT アップグレード

### 手順 1 — 現在のバージョンを確認

```bash
curl -u username:password -k -s \
  https://{BMC_IP}/redfish/v1/UpdateService/FirmwareInventory/rot_fw_active
```

### 手順 2 — 更新対象を定義 (PATCH)

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

**期待されるレスポンス:** `HTTP_CODE=200`

### 手順 3 — ファームウェアのアップロードと適用 (POST)

```bash
curl -k -u username:password -X POST \
  https://{BMC_IP}/redfish/v1/UpdateService/update \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@{Image_path}" \
  -w "\nHTTP_CODE=%{response_code}\n"
```

**期待されるレスポンス:** `HTTP_CODE=202`

### 結果

ROT のアップグレードが完了するまで約 **30 秒** 待ってから、手順 1 を再実行して新しいバージョンを確認してください。
