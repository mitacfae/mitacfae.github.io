---
title: "How to Update BIOS/BMC Logo on R1520G6 and R2520G6"
excerpt: "Step-by-step guide to customizing the BIOS splash screen and BMC web UI logo on MiTAC R1520G6 and R2520G6 servers using the Firmware Customization Portal."
date: 2025-08-28
last_modified_at: 2025-08-28
categories:
  - Firmware
tags:
  - BIOS
  - BMC
  - Logo
  - R1520G6
  - R2520G6
  - Firmware Customization
  - FUP
toc: true
toc_label: "Table of Contents"
toc_sticky: true
---

This guide explains how to customize and apply a BIOS POST splash screen logo and BMC web UI logo to MiTAC **R1520G6** and **R2520G6** servers using the Firmware Customization Portal.

## Overview

The workflow consists of three phases:

1. **Customize** — Upload logos and generate a firmware package via the Firmware Customization Portal.
2. **Prepare** — Extract the package and copy it to a USB flash drive.
3. **Flash** — Boot into UEFI Built-in Shell and run the update script.

---

## Phase 1 — Generate a Customized Firmware Package

### Step 1 — Open the Firmware Customization Portal

Navigate to the [Servertools](https://preprodservertools.mitaccomputing.com) pre-production web portal and click **Firmware Customization Portal**.

### Step 2 — Sign In with Microsoft Credentials

Authenticate using your Microsoft account when prompted by the sign-in dialog.

### Step 3 — Select the Server Family

In the **"For the latest version"** dropdown, select **MiTAC Server R520G6 Family**.

### Step 4 — Upload the BIOS Splash Screen Logo

1. Click the **Splash Screen** tab.
2. Click **Upload** and select your BIOS logo image file.

> **Requirements**
> - Resolution: **800 × 600 pixels**
> - Color depth: **8-bit or 24-bit**
> - Allowed formats: `.BMP`, `.JPG`, `.GIF`, `.PNG`
> - Maximum file size: **98 KB**

### Step 5 — Configure BMC Logos and Theme

Click the **BMC** tab. Two sub-sections are available:

#### 5.1 — Set Theme Colors (Optional)

The following UI colors can be customized:

| Setting | Description |
| --- | --- |
| Background color | Main page background |
| Header color | Top navigation bar |
| Theme color | Accent / highlight color |
| Button color | Interactive buttons |
| Header text color | Text inside the header bar |

#### 5.2 — Upload BMC Logos

Click **Upload (Main)** to select the banner logo that appears in the BMC dashboard header, then click **Upload (Login)** to select the logo shown on the BMC login page.

| Button | Purpose | Recommended Resolution | Max File Size |
| --- | --- | --- | --- |
| **Upload (Main)** | Dashboard banner logo | 300 × 70 px | 210 KB |
| **Upload (Login)** | Login page logo | 1100 × 800 px | 210 KB |

> **Tip:** Use images without a background (transparent PNG) for the best visual result on different themes.
>
> Allowed formats: `.JPG`, `.PNG`

### Step 6 — Generate the Firmware Package

1. Click the **Generate Package** button in the top-right area of the portal.
2. In the **Package Name** dialog, enter a name prefix (e.g., `FAETestLogo`).
3. Click **Generate**.

### Step 7 — Save the Package to a Local Folder

When the browser download prompt appears, save the `.zip` file to a convenient local folder (e.g., `E:\Backup\Logo\`).

---

## Phase 2 — Prepare the USB Flash Drive

### Step 8 — Extract and Copy to USB

1. Right-click the downloaded `.zip` and choose **Extract All**.
2. Inside the extracted bundle, locate the firmware folder — for example:
   ```
   FAETestLogo_8AEPNX62_bundle\8AEPNX62\FAETestLogo_R520G6_FUP_ww31\R520G6_FUP_ww31\
   ```
3. Copy the **`R520G6_FUP_ww31`** folder to the **root directory** of a USB flash drive.

---

## Phase 3 — Flash the Firmware

### Step 9 — Boot into UEFI Built-in Shell and Run the Update Script

1. Insert the USB flash drive into the server.
2. Power on or reboot, then select **UEFI: Built-in EFI Shell** from the boot menu.
3. At the shell prompt, navigate to the firmware folder and launch the script:

```shell
FS0:\> cd R520G6_FUP_ww31
FS0:\R520G6_FUP_ww31\> start.nsh
```

> **Note:** The drive mapping `FS0:` may vary. If the folder is not found, run `map -r` to list all available file systems and identify the correct drive letter.

The shell will display a directory listing similar to the following before the update begins:

```
Directory of: FS0:\R520G6_FUP_ww31\
08/28/2025  15:37 <DIR>          .
08/28/2025  15:37 <DIR>          ..
08/28/2025  08:33 <DIR>          FUP
08/28/2025  15:37          5,205 Readme&Update_Instructions.txt
08/28/2025  15:37         89,426 ReleaseNote_BIOS.txt
08/28/2025  15:37         68,414 ReleaseNote_BMC.txt
08/28/2025  15:37         13,480 ReleaseNote_CPLD.txt
08/28/2025  15:37         18,942 ReleaseNote_ROT.txt
08/28/2025  15:37          6,144 startup.nsh
       6 File(s)    201,611 bytes
       3 Dir(s)
```

---

## Verification

### Step 10 — Verify the BIOS Splash Screen (POST)

After the update completes and the server reboots, the custom logo will be displayed on screen during **Power-On Self Test (POST)**.

### Step 11 — Verify the BMC Web UI Logo

Open a browser and navigate to the BMC IP address. The custom logo should appear on:

- The **login page**
- The **main dashboard header**

---

## See Also

- [How to Remotely Upgrade R2520G6 Firmware Using Redfish Commands](https://blog.mitacfae.com/redfish/firmware/how-to-remotely-upgrade-r2520g6-firmware-using-redfish-commands/)
