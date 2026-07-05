---
title: "BOYD RAA32-10U21 CDU 냉각수 보충 SOP"
excerpt: "BOYD RAA32-10U21 CDU의 냉각수 보충, 공기 배출, 이중 펌프 이중화 검증을 위한 표준 작업 절차입니다."
date: 2026-06-24
categories:
  - sop
  - liquidcooling
tags:
  - CDU
  - BOYD
  - Liquid Cooling
  - SOP
lang: ko
lang_ref: boyd-cdu-refill-sop
header:
  teaser: /assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg
---

이 문서는 BOYD RAA32-10U21 CDU에서 냉각수를 보충하고, 갇힌 공기를 배출하며, 이중 펌프 이중화(dual-pump redundancy)를 검증하는 표준 작업 절차를 설명합니다. 이를 통해 액체 냉각 루프가 안정적인 압력으로 신뢰성 있게 작동하도록 합니다.

## 개요

BOYD RAA32-10U21 CDU를 보충 및 커미셔닝하려면 다음 단계를 따르십시오.

1. **보충용 및 배기용 호스 연결** — CDU의 `COOLANT FILLING` 및 `EXHAUST PORT` 커넥터에 호스를 연결하고, 양쪽 호스 끝을 외부 냉각수 탱크에 잠기도록 둡니다.
2. **보충 펌프 가동** — 외부 탱크에서 냉각수를 시스템으로 끌어들이고 루프 내 공기를 배출합니다.
3. **CDU 시작 및 압력 확인** — 2차 루프 리턴 압력(P2)이 허용 기준에 도달하는지 확인합니다.
4. **펌프 이중화 검증** — 강제 펌프 전환(force pump switch)을 실행하여 이중 펌프 페일오버가 정상적으로 작동하는지 확인합니다.

> **참고:** CDU 가동 후에도 `EXHAUST PORT`에 잔압이 남아 있을 수 있습니다. 가스 방출이나 냉각수 분사를 방지하기 위해 항상 호스를 먼저 위치시킨 다음 연결하십시오.

---

## 장비 목록

| 항목 | 수량 |
| --- | --- |
| G4520G6 서버 | 1 |
| BOYD RAA32-10U21 CDU | 1 |
| 외부 냉각수 저장 탱크 | 1 |
| 보충용 호스(주입 + 배기) | 2 |
| 청소용 천 | 1개 이상 |
| 개인 보호 장비(PPE) | 필요에 따라 |

---

## 안전 주의사항

### EXHAUST PORT의 잔압

CDU 후면의 `EXHAUST PORT`에는 시스템 잔압이 남아 있을 수 있습니다.

연결 시 가스 방출이나 냉각수 분사를 방지하려면:
> 먼저 호스를 위치시킨 후 퀵 커넥터를 연결하십시오. 순서를 바꾸지 마십시오.

### 보충 중 호스 이탈

보충 중 유체 충격으로 인해 호스가 저장 용기에서 튕겨 나올 수 있습니다.

외부 탱크의 입구를 청소용 천으로 단단히 막아 호스가 제자리에 고정되도록 하십시오.

### 시스템 구성

서버와 CDU 사이에 완전한 2차 액체 냉각 루프가 구성되어 폐회로(closed-circuit) 순환을 형성합니다.

---

## 보충 절차

### 1단계 — 전원 확인

CDU를 전원에 연결하고 공급 상태가 정상인지 확인합니다.

### 2단계 — 배기 호스 연결

후면 `EXHAUST PORT`의 검은색 보호 캡을 제거하고 퀵 커넥터를 이용해 첫 번째 호스를 연결합니다. 냉각수 유출을 방지하기 위해 호스 끝을 외부 냉각수 탱크에 잠긴 상태로 유지합니다.

![BOYD RAA32-10U21 CDU 후면의 EXHAUST PORT 커넥터](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg)

### 3단계 — 보충 호스 연결

후면 `COOLANT FILLING` 포트의 검은색 보호 캡을 제거하고 퀵 커넥터를 이용해 두 번째 호스를 연결합니다. 이 호스 끝 역시 탱크에 잠긴 상태로 유지합니다.

![BOYD RAA32-10U21 CDU 후면의 COOLANT FILLING 커넥터](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/coolant-filling-port.jpeg)

### 4단계 — 포트 매핑 확인

| 포트 | 설명 |
| --- | --- |
| `INT` | 시스템 보충 포트 (`COOLANT FILLING`) |
| `EXT` | 시스템 배기 포트 (`EXHAUST PORT`) |

가동이 시작되면 시스템이 외부 탱크에서 냉각수를 능동적으로 끌어들여 루프를 채웁니다.

![CDU와 외부 냉각수 탱크 사이의 INT 및 EXT 호스 배관](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/int-ext-connection.png)

### 5단계 — 보충 펌프 가동

CDU 터치 패널에서 **Refill Pump**를 켭니다.

![CDU 운전 설정 화면의 Refill Pump ON/OFF 스위치](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/refill-pump-onoff.jpeg)

### 6단계 — 공기 배출

`EXHAUST PORT`에서 기포가 나오는지 관찰합니다. 기포가 더 이상 나오지 않으면 퀵 커넥터를 완전히 분리하지 않은 상태로 잠금만 해제합니다.

### 7단계 — 보충 완료

보충이 완료되면 보충 펌프는 자동으로 정지합니다.

루프에 이미 냉각수가 있었던 경우:
- 공기 배출은 일반적으로 **3~5분** 정도 소요됩니다
- 진행하기 전에 모든 공기가 완전히 배출되었는지 확인하십시오

### 8단계 — CDU 시작

CDU 전원을 켭니다.

### 9단계 — 리턴 압력 확인

시스템 상태 화면에서 **Return Pressure (P2)**를 모니터링합니다.

![CDU 시스템 상태 화면의 Return Press P2 표시값](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/return-pressure-p2.jpeg)

#### 합격 기준

- P2 ≥ 130 kPa

#### 참고사항

시작 후 1~2분 이내에 일시적으로 압력이 낮아질 수 있습니다. 최종 판단을 내리기 전에 수치가 안정될 때까지 기다리십시오.

### 10단계 — 압력이 부족한 경우

P2가 130 kPa에 도달하지 않으면:

1. CDU 전원을 끕니다
2. Refill Pump를 켭니다
3. 자동 보충이 완료될 때까지 기다립니다
4. 8단계로 돌아갑니다

### 11단계 — 펌프 이중화 검증

**Force Pump Switch**를 실행하여 이중 펌프 페일오버가 정상적으로 작동하는지 확인합니다.

![CDU 운전 설정 화면의 Force Pump Switch 컨트롤](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/force-pump-switch.jpeg)

### 12단계 — 전원 끄기

CDU 전원을 끕니다.

### 13단계 — 호스 분리

`EXHAUST PORT`와 `COOLANT FILLING` 포트에서 호스를 모두 제거합니다. 분리 과정에서 냉각수가 누출되면 즉시 닦아냅니다.

### 14단계 — 잔류 냉각수 회수

분리된 호스를 들어 올려 중력에 의해 남아 있는 냉각수가 탱크로 다시 흘러들어가도록 합니다. 이 작업은 2인 1조로 수행하는 것을 권장합니다.

### 15단계 — 최종 점검

다음 사항을 확인합니다:
- 호스에서 물방울이 완전히 멈췄는지
- 현장에 냉각수가 남아 있지 않은지
- 장비가 원래 상태로 복원되었는지

---

## 완료 점검표

| 점검 항목 | 완료 |
| --- | --- |
| 보충 완료 | ☐ |
| 공기 배출 완료 | ☐ |
| P2 ≥ 130 kPa | ☐ |
| Force Pump Switch 검증 완료 | ☐ |
| 잔류 냉각수 정리 완료 | ☐ |
| 현장 복원 완료 | ☐ |

---

## 결론

위의 모든 단계를 완료하면 BOYD RAA32-10U21 CDU 액체 냉각 루프의 보충과 공기 배출이 끝나고 기능 검증까지 마쳐, 정상 운전을 시작할 준비가 완료됩니다.
