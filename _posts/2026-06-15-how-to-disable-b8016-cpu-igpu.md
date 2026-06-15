---
layout: post
title: "How to Disable B8016 CPU iGPU Function"
date: 2026-06-15 00:00:00 +0800
categories: [BIOS, Hardware]
tags: [B8016, iGPU, AMD, BIOS, Windows Server]
---

## Question

How to disable the B8016 CPU iGPU function?

## Answer

Update B8016 BIOS to **v9.00 (0x30)** and change the following BIOS settings. Save and reboot the B8016.

After applying these settings, **"AMD Radeon Graphics" disappears** from the Windows Server 2025 Device Manager.

---

## BIOS Settings Path

Navigate to:

```
Advanced → AMD CBS → NBIO Common Options → GFX Configuration
```

### Settings to Change

| Setting | From | To |
|---|---|---|
| dGPU Only Mode | `[Auto]` | `[Disabled]` |
| iGPU Configuration | `[Auto]` | `[iGPU Disabled]` |
| GPU Host Translation Cache | `[Auto]` | `[Disabled]` |

![BIOS GFX Configuration screen showing the required settings](/assets/images/2026-06-15-b8016-igpu/image1.png)

---

## Result

### Before

AMD Radeon(TM) Graphics is listed under Display Adapters in Device Manager.

![Device Manager before: AMD Radeon(TM) Graphics visible under Display Adapters](/assets/images/2026-06-15-b8016-igpu/image2.png)

### After

AMD Radeon(TM) Graphics no longer appears in Device Manager.

![Device Manager after: AMD Radeon(TM) Graphics removed from Display Adapters](/assets/images/2026-06-15-b8016-igpu/image3.png)
