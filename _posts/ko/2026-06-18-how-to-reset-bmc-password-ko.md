---
layout: single
title: "BMC 비밀번호 재설정 방법"
lang: ko
lang_ref: how-to-reset-bmc-password
date: 2026-06-18 00:00:00 +0800
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
toc_label: "목차"
toc_sticky: true
---

이 문서에서는 `ipmitool`을 사용하여 BMC 비밀번호를 재설정하는 방법을 설명합니다. BMC에 네트워크로 접속 가능한 경우(원격 재설정)와 BMC 비밀번호를 모르거나 분실한 경우(로컬 재설정) 두 가지 시나리오를 모두 다룹니다.

## 개요

BMC 비밀번호를 재설정하는 방법에는 두 가지 시나리오가 있습니다.

1. **원격 재설정(Remote reset)** — 유효한 BMC 자격 증명과 네트워크 접속이 가능한 경우입니다. LAN을 통해 `ipmitool`을 사용하여 원격으로 비밀번호 재설정을 트리거합니다.
2. **로컬 재설정(Local reset)** — BMC 비밀번호를 모르거나 분실한 경우입니다. 자격 증명 없이 재설정하려면 서버 로컬 호스트에서 직접(in-band) `ipmitool`을 실행해야 합니다.

> **참고:** 재설정 후에는 BMC가 자동으로 재부팅됩니다. 재부팅 후 로그인할 때는 **BMC 기본 비밀번호**를 사용해야 합니다.

---

## 사전 준비 사항

| 항목 | 요구 사항 |
|---|---|
| 도구 | `ipmitool` 설치 필요 |
| 원격 재설정 | BMC IP로의 네트워크 접속 및 유효한 자격 증명 |
| 로컬 재설정 | 서버 OS에 대한 물리적 또는 콘솔 접속 |

---

## 시나리오 1: 원격 재설정

유효한 BMC 자격 증명과 네트워크 접속이 가능한 경우 이 방법을 사용합니다.

### 명령어

```bash
ipmitool -H {BMC_IP} -U {BMC_username} -P {BMC_password} raw 0x32 0x66
```

`{BMC_IP}`, `{BMC_username}`, `{BMC_password}`를 실제 값으로 바꿔서 입력합니다.

### 예시

```bash
ipmitool -H 192.168.1.100 -U admin -P current_password raw 0x32 0x66
```

### 결과

BMC가 자동으로 재부팅됩니다. 재부팅 후 **BMC 기본 비밀번호**로 로그인합니다.

---

## 시나리오 2: 로컬 재설정 (비밀번호 분실 시)

BMC 비밀번호를 모르거나 분실했고 원격 접속이 불가능한 경우 이 방법을 사용합니다.

### 명령어

다음 명령어를 서버에서 직접(in-band) 실행합니다. IP나 자격 증명이 필요하지 않습니다.

```bash
ipmitool raw 0x32 0x66
```

### 결과

BMC가 자동으로 재부팅됩니다. 재부팅 후 **BMC 기본 비밀번호**로 로그인합니다.

---

## 재설정 후

BMC가 재부팅되면 공장 출하 시 기본 자격 증명으로 로그인합니다. 기본 사용자 이름과 비밀번호는 서버의 서비스 라벨에 인쇄되어 있거나 플랫폼의 하드웨어 가이드에 기재되어 있습니다.

> 기본 자격 증명으로 로그인한 직후에는 BMC 비밀번호를 즉시 변경하는 것을 권장합니다.
