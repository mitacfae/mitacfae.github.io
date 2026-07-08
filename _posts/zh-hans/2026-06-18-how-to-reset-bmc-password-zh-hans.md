---
layout: single
title: "如何重置 BMC 密码"
date: 2026-06-18 00:00:00 +0800
lang: zh-Hans
lang_ref: how-to-reset-bmc-password
categories:
  - IPMI
  - BMC
tags:
  - BMC
  - IPMI
  - ipmitool
  - Password
  - Security
author_profile: true
read_time: true
share: true
related: true
comments: true
toc: true
toc_label: "目录"
toc_sticky: true
---

本文说明如何使用 `ipmitool` 重置 BMC 密码，涵盖两种场景：远程重置（仍可通过网络连接到 BMC）以及本地重置（BMC 密码未知或丢失时）。

## 概述

重置 BMC 密码有两种场景：

1. **远程重置** — 您仍拥有有效的 BMC 账号密码与网络连接，可通过 LAN 使用 `ipmitool` 远程触发密码重置。
2. **本地重置** — BMC 密码未知或丢失时，必须直接在本机主机上（in-band）执行 `ipmitool`，无需账号密码即可重置。

> **注意：** 无论采用哪一种重置方式，BMC 都会自动重新启动。重启后，您需要使用 **BMC 默认密码** 才能登录。

---

## 事前准备

| 项目 | 需求 |
|---|---|
| 工具 | 已安装 `ipmitool` |
| 远程重置 | 具备连接到 BMC IP 的网络，以及有效的账号密码 |
| 本地重置 | 具备服务器操作系统的物理或控制台访问权限 |

---

## 场景一：远程重置

当您仍拥有有效的 BMC 账号密码与网络连接时，可使用此方法。

### 命令

```bash
ipmitool -H {BMC_IP} -U {BMC_username} -P {BMC_password} raw 0x32 0x66
```

请将 `{BMC_IP}`、`{BMC_username}` 及 `{BMC_password}` 替换为实际数值。

### 示例

```bash
ipmitool -H 192.168.1.100 -U admin -P current_password raw 0x32 0x66
```

### 结果

BMC 将自动重新启动。重启后，请使用 **BMC 默认密码** 登录。

---

## 场景二：本地重置（密码丢失）

当 BMC 密码未知或丢失，且无法通过远程访问时，可使用此方法。

### 命令

直接在服务器上执行以下命令（in-band 方式，不需要 IP 或账号密码）：

```bash
ipmitool raw 0x32 0x66
```

### 结果

BMC 将自动重新启动。重启后，请使用 **BMC 默认密码** 登录。

---

## 重置后的步骤

BMC 重新启动后，请使用出厂默认账号密码登录。默认的用户名与密码通常印制在服务器的服务标签（service label）上，或记载于该平台的硬件使用手册中。

> 建议在使用默认账号密码登录后，立即更改 BMC 密码。
