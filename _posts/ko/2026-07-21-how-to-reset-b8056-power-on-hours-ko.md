---
title: "B8056 Power-On Hours(가동 시간) 초기화 방법"
excerpt: "이 문서에서는 Linux 스크립트로 ipmitool 명령을 실행하여 B8056 플랫폼의 Power-On Hours(POH) 카운터를 초기화하는 방법을 설명합니다."
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
lang: ko
lang_ref: how-to-reset-b8056-power-on-hours
toc: true
toc_label: "목차"
toc_sticky: true
header:
  teaser: /assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png
---

이 문서에서는 B8056 플랫폼의 **Power-On Hours(POH)** 카운터를 초기화하는 방법을 설명합니다. POH 값은 내부적으로 `ipmitool` 명령을 BMC로 전송하는 래퍼 스크립트를 Linux 호스트에서 실행하여 초기화할 수 있습니다.

## 개요

B8056의 Power-On Hours 카운터는 내부적으로 `ipmitool`을 호출하는 Linux 셸 스크립트를 사용해 초기화할 수 있습니다. 보드 교체 후, 번인(burn-in) 테스트 이후, 또는 시스템을 출하하거나 다시 서비스에 투입하기 전에 누적된 POH 값을 초기화해야 하는 경우에 유용합니다.

![초기화 전 BMC에 표시되는 Power-On Hours 값](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png)

---

## 사전 요구사항

| 항목       | 요구 사항                                     |
| ---------- | ---------------------------------------------- |
| 도구       | `8056_clear_poh.sh` 스크립트 (`ipmitool` 래퍼) |
| 네트워크   | 접근 가능한 BMC IP 주소                        |
| 계정 정보  | 유효한 BMC 사용자 이름과 비밀번호              |
| 실행 환경  | `ipmitool`이 설치된 Linux 호스트               |

---

## 절차

### 명령어

Linux 환경에서 스크립트를 실행하며, BMC 사용자 이름, BMC 비밀번호, BMC IP 주소를 인자로 전달합니다.

```
./8056_clear_poh.sh {BMC_username} {BMC_password} {BMC_IP_Address}
```

`{BMC_username}`, `{BMC_password}`, `{BMC_IP_Address}`는 대상 시스템의 실제 값으로 바꿔서 사용하세요.

### 예시

```
$ ./8056_clear_poh.sh root tyan@123 10.99.238.73
```

![대상 BMC에 대해 POH 초기화 스크립트를 실행하는 예시](/assets/images/bmc/how-to-reset-b8056-power-on-hours/script-execution-example.png)

[Download 8056_clear_poh.sh](/assets/files/bmc/how-to-reset-b8056-power-on-hours/8056_clear_poh.sh)


### 결과

스크립트 실행이 완료되면 Power-On Hours 카운터가 초기화되며, 다시 조회하면 초기화된 상태로 표시됩니다.

![스크립트 실행 후 Power-On Hours가 초기화된 것을 확인](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-after-reset.png)

---

## 초기화 이후

시스템을 다시 서비스에 투입하기 전에 BMC 웹 GUI 또는 `ipmitool`을 통해 POH 값이 0(또는 예상되는 기준값)으로 표시되는지 다시 한번 확인하세요.

> **참고:** 이 작업은 누적된 Power-On Hours 카운터만 초기화하며, BMC의 네트워크 설정, 사용자 계정, 기타 센서 로그에는 영향을 주지 않습니다.
