---
layout: single
title: "How to Reset BMC Password"
date: 2026-06-18 00:00:00 +0800
lang: en
lang_ref: how-to-reset-bmc-password
Description: "This article explains how to reset the BMC password using `ipmitool`, covering both remote reset (when you still have network access to the BMC) and local reset (when the BMC password is unknown or missing)."
categories:
  - IPMI
  - BMC
  - How to
tags:
  - BMC
  - IPMI
  - ipmitool
  - Password
  - Security
author_profile: true
lang: en
read_time: true
share: true
related: true
comments: true
toc: true
toc_label: "Table of Contents"
toc_sticky: true
---

This article explains how to reset the BMC password using `ipmitool`, covering both remote reset (when you still have network access to the BMC) and local reset (when the BMC password is unknown or missing).

## Overview

There are two scenarios for resetting the BMC password:

1. **Remote reset** — You still have valid BMC credentials and network access. Use `ipmitool` over LAN to trigger a password reset remotely.
2. **Local reset** — The BMC password is unknown or missing. You must run `ipmitool` directly on the local host (in-band) to reset without credentials.

> **Note:** After either reset, the BMC will restart automatically. You will need to use the **BMC default password** to log in after the restart.

---

## Prerequisites

| Item | Requirement |
|---|---|
| Tool | `ipmitool` installed |
| Remote reset | Network access to BMC IP + valid credentials |
| Local reset | Physical or console access to the server OS |

---

## Scenario 1: Remote Reset

Use this method when you still have valid BMC credentials and network access.

### Command

```bash
ipmitool -H {BMC_IP} -U {BMC_username} -P {BMC_password} raw 0x32 0x66
```

Replace `{BMC_IP}`, `{BMC_username}`, and `{BMC_password}` with the actual values.

### Example

```bash
ipmitool -H 192.168.1.100 -U admin -P current_password raw 0x32 0x66
```

### Result

The BMC will restart automatically. After the restart, log in using the **BMC default password**.

---

## Scenario 2: Local Reset (Password Missing)

Use this method when the BMC password is unknown or missing and remote access is unavailable.

### Command

Run the following command directly on the server (in-band, no IP or credentials required):

```bash
ipmitool raw 0x32 0x66
```

### Result

The BMC will restart automatically. After the restart, log in using the **BMC default password**.

---

## After Reset

Once the BMC restarts, log in with the factory default credentials. The default username and password are printed on the server's service label or documented in the platform's hardware guide.

> It is recommended to change the BMC password immediately after logging in with the default credentials.
