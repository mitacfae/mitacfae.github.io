---
title: "BOYD RAA32-10U21 CDU Refill SOP"
excerpt: "Standard operating procedure for refilling coolant, venting air, and verifying dual-pump redundancy on the BOYD RAA32-10U21 CDU."
categories:
  - sop
  - liquidcooling
tags:
  - CDU
  - BOYD
  - Liquid Cooling
  - SOP
lang: en
lang_ref: boyd-cdu-refill-sop
header:
  teaser: /assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg
---

This article describes the standard operating procedure for refilling coolant, venting trapped air, and verifying dual-pump redundancy on a BOYD RAA32-10U21 CDU, ensuring the liquid cooling loop runs reliably at stable pressure.

## Overview

To refill and commission the BOYD RAA32-10U21 CDU, follow these steps:

1. **Connect the refill and exhaust hoses** — Attach hoses to the CDU's `COOLANT FILLING` and `EXHAUST PORT` connectors, with both hose ends submerged in an external coolant tank.
2. **Run the refill pump** — Draw coolant from the external tank into the system and bleed air from the loop.
3. **Start the CDU and check pressure** — Confirm the secondary loop return pressure (P2) reaches the acceptance threshold.
4. **Verify pump redundancy** — Trigger a forced pump switch to confirm dual-pump failover works correctly.

> **Note:** Residual pressure may remain in the `EXHAUST PORT` after the CDU has been running. Always position the hose first, then make the connection, to avoid gas release or coolant spray.

---

## Equipment List

| Item | Qty |
| --- | --- |
| G4520G6 server | 1 |
| BOYD RAA32-10U21 CDU | 1 |
| External coolant storage tank | 1 |
| Refill hoses (inlet + exhaust) | 2 |
| Cleaning cloth | 1+ |
| Personal Protective Equipment (PPE) | as required |

---

## Safety Precautions

### Residual pressure at the EXHAUST PORT

The `EXHAUST PORT` on the rear of the CDU may retain residual system pressure.

To avoid gas release or coolant spray when connecting:
> Position the hose first, then connect the quick connector — never the other way around.

### Hose kick-out during refill

Fluid impact during refill can cause the hose to jump out of the storage container.

Pack the opening of the external tank tightly with a cleaning cloth to keep the hose seated.

### System configuration

A complete secondary liquid cooling loop is established between the server and the CDU, forming a closed-circuit cycle.

---

## Refill Procedure

### Step 1 — Confirm Power

Connect the CDU to power and confirm the supply is normal.

### Step 2 — Connect the Exhaust Hose

Remove the black protective cap from the rear `EXHAUST PORT` and attach the first hose using its quick connector. Keep the hose end submerged in the external coolant tank to prevent spillage.

![EXHAUST PORT connector on the rear of the BOYD RAA32-10U21 CDU](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg)

### Step 3 — Connect the Refill Hose

Remove the black protective cap from the rear `COOLANT FILLING` port and attach the second hose using its quick connector. Keep this hose end submerged in the tank as well.

![COOLANT FILLING connector on the rear of the BOYD RAA32-10U21 CDU](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/coolant-filling-port.jpeg)

### Step 4 — Confirm Port Mapping

| Port | Description |
| --- | --- |
| `INT` | System refill port (`COOLANT FILLING`) |
| `EXT` | System exhaust port (`EXHAUST PORT`) |

Once running, the system actively draws coolant from the external tank to fill the loop.

![INT and EXT hose routing between the CDU and the external coolant tank](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/int-ext-connection.png)

### Step 5 — Start the Refill Pump

Turn on the **Refill Pump** from the CDU touch panel.

![Refill Pump ON/OFF switch on the CDU operating setpoint screen](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/refill-pump-onoff.jpeg)

### Step 6 — Bleed Air

Watch the `EXHAUST PORT` for air bubbles. Once no bubbles remain, release the quick connector lock without fully disconnecting it.

### Step 7 — Complete Refilling

The refill pump stops automatically once filling is complete.

If coolant was already present in the loop:
- Bleeding typically takes **3–5 minutes**
- Confirm all air has been fully expelled before proceeding

### Step 8 — Start the CDU

Power on the CDU.

### Step 9 — Check Return Pressure

Monitor **Return Pressure (P2)** on the system status screen.

![Return Press P2 reading on the CDU system status screen](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/return-pressure-p2.jpeg)

#### Acceptance Criteria

- P2 ≥ 130 kPa

#### Notes

A transient pressure dip may appear within 1–2 minutes of startup. Wait for the reading to stabilize before making a final judgment.

### Step 10 — If Pressure Is Insufficient

If P2 does not reach 130 kPa:

1. Turn off the CDU
2. Turn on the Refill Pump
3. Wait for the automatic refill to finish
4. Return to Step 8

### Step 11 — Verify Pump Redundancy

Trigger **Force Pump Switch** and confirm the dual-pump failover behaves correctly.

![Force Pump Switch control on the CDU operating setpoint screen](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/force-pump-switch.jpeg)

### Step 12 — Power Off

Turn off the CDU.

### Step 13 — Disconnect Hoses

Remove the hoses from both the `EXHAUST PORT` and `COOLANT FILLING` ports. Wipe up any coolant that leaks out during disconnection immediately.

### Step 14 — Recover Residual Coolant

Raise the disconnected hoses so gravity drains any remaining coolant back into the tank. Performing this step with two people is recommended.

### Step 15 — Final Check

Confirm:
- Hoses have fully finished dripping
- No coolant remains on site
- The unit is restored to its original state

---

## Acceptance Checklist

| Check Item | Done |
| --- | --- |
| Refill completed | ☐ |
| Air bleeding completed | ☐ |
| P2 ≥ 130 kPa | ☐ |
| Force Pump Switch verified | ☐ |
| Residual coolant cleaned up | ☐ |
| Site restored | ☐ |

---

## Conclusion

Once all steps above are complete, the BOYD RAA32-10U21 CDU liquid cooling loop has been refilled, bled of air, and functionally verified, and is ready for normal operation.
