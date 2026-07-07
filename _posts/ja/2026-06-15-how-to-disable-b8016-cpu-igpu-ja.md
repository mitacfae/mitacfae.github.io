---
layout: single
title: "B8016 CPU iGPU 機能の無効化方法"
lang: ja
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
toc_label: "目次"
---

本記事では、BIOS 設定を通じて B8016 プラットフォームの CPU 内蔵 GPU(iGPU)を無効化する方法を紹介します。オペレーティングシステムのデバイスマネージャーから AMD Radeon Graphics デバイスを削除する必要があるシナリオに対応します。

## 概要

B8016 で iGPU を無効化するには、以下の手順に従います。

1. **BIOS の更新** — 変更を行う前に、B8016 が BIOS **v9.00 (0x30)** 以降で動作していることを確認します。
2. **GFX Configuration への移動** — BIOS の AMD CBS メニューから iGPU 関連の設定にアクセスします。
3. **必要な設定の適用** — dGPU Only Mode、iGPU Configuration、GPU Host Translation Cache を無効化します。
4. **保存して再起動** — BIOS の変更を保存し、システムを再起動して適用します。

> **注意:** これらの設定を適用すると、Windows Server 2025 のデバイスマネージャーから **「AMD Radeon Graphics」が表示されなくなります**。

---

## 前提条件

| 項目 | 要件 |
|---|---|
| BIOS バージョン | v9.00 (0x30) 以降 |
| オペレーティングシステム | Windows Server 2025 |
| 必要なアクセス権限 | BIOS への物理的またはリモート KVM アクセス |

---

## BIOS 設定

### 1. BIOS セットアップ画面に入る

B8016 の電源を入れるか再起動し、POST 中に該当キーを押して BIOS セットアップ画面に入ります。

### 2. GFX Configuration へ移動

```
Advanced → AMD CBS → NBIO Common Options → GFX Configuration
```

### 3. 必要な設定の適用

以下の 3 つの設定をデフォルト値から次のように変更します。

| 設定項目 | 変更前 | 変更後 |
|---|---|---|
| dGPU Only Mode | `[Auto]` | `[Disabled]` |
| iGPU Configuration | `[Auto]` | `[iGPU Disabled]` |
| GPU Host Translation Cache | `[Auto]` | `[Disabled]` |

![必要な設定が表示された BIOS GFX Configuration 画面](/assets/images/2026-06-15-b8016-igpu/image1.png)

### 4. 保存して再起動

**F10** キー(または Save & Exit オプション)を押して変更を保存し、システムを再起動します。

---

## 確認

システムの再起動後、Windows Server 2025 で **デバイスマネージャー** を開き、**ディスプレイ アダプター** の項目で結果を確認します。

### 変更前

デバイスマネージャーのディスプレイ アダプター一覧に AMD Radeon(TM) Graphics が表示されます。

![変更前のデバイスマネージャー:ディスプレイ アダプターに表示される AMD Radeon(TM) Graphics](/assets/images/2026-06-15-b8016-igpu/image2.png)

### 変更後

デバイスマネージャーに AMD Radeon(TM) Graphics は表示されなくなり、**Microsoft 基本ディスプレイ アダプター** のみが残ります。

![変更後のデバイスマネージャー:ディスプレイ アダプターから削除された AMD Radeon(TM) Graphics](/assets/images/2026-06-15-b8016-igpu/image3.png)
