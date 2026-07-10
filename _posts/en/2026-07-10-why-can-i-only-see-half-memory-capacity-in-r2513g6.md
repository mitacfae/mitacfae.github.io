---
layout: single
title: "Why Can I Only See Half Memory Capacity (384GB) in R2513G6?"
lang: en
lang_ref: why-can-i-only-see-half-memory-capacity-in-r2513g6
Description: "This symptom may be caused by one or more defective memory modules. Please boot the R2513G6 into BIOS and change the BIOS setting"
permalink: /bios/hardware/why-can-i-only-see-half-memory-capacity-in-r2513g6/
date: 2026-07-10 00:00:00 +0800
categories:
  - BIOS
  - Hardware
  - KBase
tags:
  - R2513G6
  - Memory
  - DIMM
  - BIOS
  - BMC
author_profile: true
read_time: true
share: true
related: true
comments: true
toc: true
toc_label: "Table of Contents"
toc_sticky: true
---

**Question:** I've installed 768GB (96GB x8) in an R2513G6 system. Why can I only see half the memory capacity (384GB)?

![Memory capacity showing only 384GB instead of the installed 768GB](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-1.png)

![Memory summary confirming half capacity is reported](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-2.png)

## Answer

This symptom may be caused by one or more defective memory modules.

Please boot the R2513G6 into BIOS and change the following BIOS setting:

```
Socket Configuration → Memory Configuration → Enforce Population POR
```

Change this setting **from `Enabled` to `Disabled`**.

![BIOS setting: Enforce Population POR changed from Enabled to Disabled](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-3.png)

## Result

After saving and restarting the R2513G6, you'll see that one 96GB memory module is now reported as missing.

![Memory summary after the change, showing one missing 96GB module](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-4.png)

![Total capacity now reflecting the missing module](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-5.png)

You can then check **Memory Topology** to identify which memory module is missing (in this case, `P0_CHH_DIM0`). This event can also be found in the BMC event log.

![Memory Topology screen identifying the missing DIMM at P0_CHH_DIM0](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-6.png)

![BMC event log entry recording the missing memory module](/assets/images/2026-07-10-r2513g6-memory-half-capacity/r2513g6-memory-7.png)

---

**Summary:** With `Enforce Population POR` enabled, a defective DIMM can cause the BIOS to silently disable an entire memory channel/region as a safety measure, resulting in only half the installed capacity being reported. Disabling this setting allows the system to boot with only the specific defective module excluded, making it visible in both the memory topology and BMC event log — which lets you pinpoint exactly which DIMM needs to be replaced.
