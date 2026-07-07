---
layout: single
title: "B8016 CPU iGPU 기능 비활성화하는 방법"
lang: ko
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
toc_label: "목차"
---

이 문서에서는 BIOS 설정을 통해 B8016 플랫폼의 CPU 내장 GPU(iGPU)를 비활성화하는 방법을 소개하며, 운영체제의 장치 관리자에서 AMD Radeon Graphics 장치를 제거해야 하는 상황을 다룹니다.

## 개요

B8016에서 iGPU를 비활성화하려면 다음 단계를 따르세요.

1. **BIOS 업데이트** — 변경 작업을 진행하기 전에 B8016이 BIOS **v9.00 (0x30)** 이상 버전으로 실행 중인지 확인합니다.
2. **GFX Configuration으로 이동** — BIOS의 AMD CBS 메뉴에서 iGPU 관련 설정에 접근합니다.
3. **필요한 설정 적용** — dGPU Only Mode, iGPU Configuration, GPU Host Translation Cache를 비활성화합니다.
4. **저장 후 재부팅** — BIOS 변경 사항을 저장하고 시스템을 재부팅하여 적용합니다.

> **참고:** 이 설정을 적용하면 Windows Server 2025 장치 관리자에서 **"AMD Radeon Graphics"가 사라집니다**.

---

## 사전 준비 사항

| 항목 | 요구 사항 |
|---|---|
| BIOS 버전 | v9.00 (0x30) 이상 |
| 운영체제 | Windows Server 2025 |
| 필요한 접근 권한 | BIOS에 대한 물리적 또는 원격 KVM 접속 |

---

## BIOS 설정

### 1. BIOS 설정 화면 진입

B8016의 전원을 켜거나 재부팅한 후, POST 과정 중 해당 키를 눌러 BIOS 설정 화면으로 진입합니다.

### 2. GFX Configuration으로 이동

```
Advanced → AMD CBS → NBIO Common Options → GFX Configuration
```

### 3. 필요한 설정 적용

다음 세 가지 설정을 기본값에서 아래와 같이 변경합니다.

| 설정 | 변경 전 | 변경 후 |
|---|---|---|
| dGPU Only Mode | `[Auto]` | `[Disabled]` |
| iGPU Configuration | `[Auto]` | `[iGPU Disabled]` |
| GPU Host Translation Cache | `[Auto]` | `[Disabled]` |

![필요한 설정이 표시된 BIOS GFX Configuration 화면](/assets/images/2026-06-15-b8016-igpu/image1.png)

### 4. 저장 후 재부팅

**F10** 키(또는 Save & Exit 옵션)를 눌러 변경 사항을 저장하고 시스템을 재부팅합니다.

---

## 확인

시스템이 재부팅된 후, Windows Server 2025에서 **장치 관리자**를 열고 **디스플레이 어댑터** 항목에서 결과를 확인합니다.

### 변경 전

장치 관리자의 디스플레이 어댑터 목록에 AMD Radeon(TM) Graphics가 표시됩니다.

![변경 전 장치 관리자: 디스플레이 어댑터에 표시되는 AMD Radeon(TM) Graphics](/assets/images/2026-06-15-b8016-igpu/image2.png)

### 변경 후

장치 관리자에 더 이상 AMD Radeon(TM) Graphics가 표시되지 않습니다. **Microsoft 기본 디스플레이 어댑터**만 남습니다.

![변경 후 장치 관리자: 디스플레이 어댑터에서 제거된 AMD Radeon(TM) Graphics](/assets/images/2026-06-15-b8016-igpu/image3.png)
