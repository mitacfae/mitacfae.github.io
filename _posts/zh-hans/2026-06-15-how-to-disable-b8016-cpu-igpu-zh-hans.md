---
layout: single
title: "如何禁用 B8016 CPU iGPU 功能"
lang: zh-Hans
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
toc_label: "目录"
---

本文提供通过 BIOS 设置禁用 B8016 平台 CPU 集成显卡(iGPU)的解决方案,适用于需要从操作系统设备管理器中移除 AMD Radeon Graphics 设备的场景。

## 概览

要禁用 B8016 上的 iGPU,请按照以下步骤操作:

1. **更新 BIOS** — 进行更改前,请确认 B8016 已更新至 BIOS **v9.00 (0x30)** 或更新版本。
2. **进入 GFX Configuration** — 在 BIOS 的 AMD CBS 菜单中进入 iGPU 相关设置。
3. **应用所需设置** — 禁用 dGPU Only Mode、iGPU Configuration 和 GPU Host Translation Cache。
4. **保存并重启** — 保存 BIOS 更改并重启系统以应用设置。

> **注意:** 应用这些设置后,Windows Server 2025 设备管理器中的 **“AMD Radeon Graphics”将会消失**。

---

## 前提条件

| 项目 | 要求 |
|---|---|
| BIOS 版本 | v9.00 (0x30) 或更新版本 |
| 操作系统 | Windows Server 2025 |
| 所需访问权限 | 对 BIOS 的物理或远程 KVM 访问权限 |

---

## BIOS 设置

### 1. 进入 BIOS 设置界面

开机或重启 B8016,并在 POST 过程中按下相应按键以进入 BIOS 设置界面。

### 2. 进入 GFX Configuration

```
Advanced → AMD CBS → NBIO Common Options → GFX Configuration
```

### 3. 应用所需设置

将以下三项设置由默认值更改为:

| 设置项 | 由 | 改为 |
|---|---|---|
| dGPU Only Mode | `[Auto]` | `[Disabled]` |
| iGPU Configuration | `[Auto]` | `[iGPU Disabled]` |
| GPU Host Translation Cache | `[Auto]` | `[Disabled]` |

![显示所需设置的 BIOS GFX Configuration 界面](/assets/images/2026-06-15-b8016-igpu/image1.png)

### 4. 保存并重启

按下 **F10**(或选择 Save & Exit 选项)以保存更改并重启系统。

---

## 验证

系统重启后,打开 Windows Server 2025 的 **设备管理器**,并在 **显示适配器** 项目下确认结果。

### 更改前

设备管理器的显示适配器列表中会列出 AMD Radeon(TM) Graphics。

![更改前的设备管理器:显示适配器下可见 AMD Radeon(TM) Graphics](/assets/images/2026-06-15-b8016-igpu/image2.png)

### 更改后

设备管理器中不再出现 AMD Radeon(TM) Graphics,仅剩下 **Microsoft 基本显示适配器**。

![更改后的设备管理器:显示适配器下的 AMD Radeon(TM) Graphics 已移除](/assets/images/2026-06-15-b8016-igpu/image3.png)
