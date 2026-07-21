---
title: "如何重置 B8056 开机时数 (Power-On Hours)"
excerpt: "本文说明如何通过 Linux 脚本调用 ipmitool 命令，重置 B8056 平台的 Power-On Hours (POH) 计数器。"
categories:
  - BMC
  - IPMI
  - How to
tags:
  - BMC
  - IPMI
  - ipmitool
  - Power-On Hours
  - B8056
lang: zh-Hans
lang_ref: how-to-reset-b8056-power-on-hours
toc: true
toc_label: "目录"
toc_sticky: true
header:
  teaser: /assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png
---

本文说明如何重置 B8056 平台的 **Power-On Hours (POH)** 开机时数计数器。POH 数值可以通过在 Linux 主机端运行一个封装脚本来清除，该脚本底层会调用 `ipmitool` 命令发送给 BMC。

## 概述

B8056 的 Power-On Hours 计数器可以通过一个 Linux shell 脚本重置，该脚本内部调用 `ipmitool`。这在更换主板、老化测试（burn-in）之后，或任何需要在系统出厂、重新上线前清除累计 POH 数值的场景下都很实用。

![重置前 BMC 显示的 Power-On Hours 数值](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png)

---

## 前置条件

| 项目       | 要求                                       |
| ---------- | ------------------------------------------ |
| 工具       | `8056_clear_poh.sh` 脚本（封装 `ipmitool`）|
| 网络连接   | 可访问的 BMC IP 地址                       |
| 账号密码   | 有效的 BMC 用户名与密码                     |
| 运行环境   | 已安装 `ipmitool` 的 Linux 主机             |

---

## 操作步骤

### 命令

在 Linux 环境中运行脚本，并传入 BMC 用户名、BMC 密码与 BMC IP 地址作为参数：

```
./8056_clear_poh.sh {BMC_username} {BMC_password} {BMC_IP_Address}
```

请将 `{BMC_username}`、`{BMC_password}`、`{BMC_IP_Address}` 替换为目标系统的实际值。

### 示例

```
$ ./8056_clear_poh.sh root tyan@123 10.99.238.73
```

![对目标 BMC 运行 POH 清除脚本的示例](/assets/images/bmc/how-to-reset-b8056-power-on-hours/script-execution-example.png)

[Download 8056_clear_poh.sh](/assets/files/bmc/how-to-reset-b8056-power-on-hours/8056_clear_poh.sh)

### 执行结果

脚本运行完成后，Power-On Hours 计数器会被清除，重新读取时会显示已重置。

![运行脚本后确认 Power-On Hours 已重置](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-after-reset.png)

---

## 重置后

请通过 BMC 网页界面或 `ipmitool` 再次确认 POH 数值，确保其已归零（或符合预期的基准值），再将系统交付使用。

> **注意：** 此操作仅会清除累计的 Power-On Hours 计数器，不会影响 BMC 的网络设置、用户账号或其他传感器日志。
