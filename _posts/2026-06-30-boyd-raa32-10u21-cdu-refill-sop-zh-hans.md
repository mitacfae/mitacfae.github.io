---
title: "BOYD RAA32-10U21 CDU 补液 SOP"
excerpt: "BOYD RAA32-10U21 CDU 补充冷却液、排出空气以及验证双泵冗余的标准操作规程。"
categories:
  - sop
  - liquidcooling
tags:
  - CDU
  - BOYD
  - Liquid Cooling
  - SOP
lang_ref: boyd-cdu-refill-sop
header:
  teaser: /assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg
---

本文介绍了 BOYD RAA32-10U21 CDU 补充冷却液、排出气泡以及验证双泵冗余的标准操作规程（SOP），以确保液冷回路在稳定的压力下可靠运行。

## 概述

要对 BOYD RAA32-10U21 CDU 进行补液和调试，请遵循以下步骤：

1. **连接补液管和排气管** —— 将软管连接到 CDU 的 `COOLANT FILLING`（补液口）和 `EXHAUST PORT`（排气口）接头，并将两根软管的末端浸入外部冷却液箱中。
2. **运行补液泵** —— 将外部水箱中的冷却液吸入系统，并排出回路中的空气。
3. **启动 CDU 并检查压力** —— 确认二次侧回路回水压力（P2）达到验收阈值。
4. **验证水泵冗余** —— 触发强制换泵，以确认双泵冗余切换功能正常工作。

> **注意：** CDU 运行后，`EXHAUST PORT` 中可能会残留压力。请务必先定位软管，然后再进行连接，以避免气体释放或冷却液喷溅。

---

## 设备清单

| 物品 | 数量 |
| --- | --- |
| G4520G6 服务器 | 1 |
| BOYD RAA32-10U21 CDU | 1 |
| 外部冷却液储水箱 | 1 |
| 补液软管（入口 + 排气） | 2 |
| 清洁布 | 1+ |
| 个人防护装备（PPE） | 按需 |

---

## 安全注意事项

### EXHAUST PORT（排气口）残留压力

CDU 后部的 `EXHAUST PORT` 可能会保留系统残压。

为避免连接时气体释放或冷却液喷溅：
> 先定位软管，然后连接快速接头 —— 切勿颠倒顺序。

### 补液期间软管跳动

补液期间的液体冲击可能会导致软管从储液容器中跳出。

用清洁布将外部水箱的开口处塞紧，以保持软管固定就位。

### 系统配置

服务器与 CDU 之间建立了完整的二次侧液冷回路，形成闭式循环。

---

## 补液步骤

### 步骤 1 —— 确认电源

将 CDU 连接到电源并确认供电正常。

### 步骤 2 —— 连接排气管

拆下后部 `EXHAUST PORT` 的黑色保护帽，并使用快速接头连接第一根软管。保持软管末端浸入外部冷却液箱中以防溅漏。

![BOYD RAA32-10U21 CDU 后部的 EXHAUST PORT 接头](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg)

### 步骤 3 —— 连接补液管

拆下后部 `COOLANT FILLING` 处的黑色保护帽，并使用快速接头连接第二根软管。同样将该软管末端浸入水箱中。

![BOYD RAA32-10U21 CDU 后部的 COOLANT FILLING 接头](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/coolant-filling-port.jpeg)

### 步骤 4 —— 确认接口对应关系

| 接口 | 描述 |
| --- | --- |
| `INT` | 系统补液口 (`COOLANT FILLING`) |
| `EXT` | 系统排气口 (`EXHAUST PORT`) |

运行后，系统会自动从外部水箱吸取冷却液以填充回路。

![CDU 与外部冷却液箱之间的 INT 和 EXT 软管布线](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/int-ext-connection.png)

### 步骤 5 —— 启动补液泵

从 CDU 触摸屏上开启 **Refill Pump**（补液泵）。

![CDU 运行设定值界面上的补液泵开关](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/refill-pump-onoff.jpeg)

### 步骤 6 —— 排出空气

观察 `EXHAUST PORT` 是否有气泡。一旦没有气泡，松开快速接头锁扣，但不要完全断开连接。

### 步骤 7 —— 完成补液

补液完成后，补液泵会自动停止。

如果回路中此前已有冷却液：
- 排气通常需要 **3–5 分钟**
- 在继续下一步之前，确认所有空气已完全排出

### 步骤 8 —— 启动 CDU

开启 CDU 电源。

### 步骤 9 —— 检查回水压力

在系统状态界面上监控 **Return Pressure (P2)**（回水压力）。

![CDU 系统状态界面上的回水压力 P2 读数](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/return-pressure-p2.jpeg)

#### 验收标准

- P2 ≥ 130 kPa

#### 说明

启动后 1–2 分钟内可能会出现短暂的压力下降。等待读数稳定后再做出最终判定。

### 步骤 10 —— 如果压力不足

如果 P2 未达到 130 kPa：

1. 关闭 CDU
2. 开启补液泵
3. 等待自动补液完成
4. 返回步骤 8

### 步骤 11 —— 验证水泵冗余

触发 **Force Pump Switch**（强制换泵），并确认双泵冗余切换功能表现正常。

![CDU 运行设定值界面上的强制换泵控制](/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/force-pump-switch.jpeg)

### 步骤 12 —— 关闭电源

关闭 CDU。

### 步骤 13 —— 断开软管

拆除 `EXHAUST PORT` 和 `COOLANT FILLING` 接口上的软管。立即擦拭拆除过程中漏出的任何冷却液。

### 步骤 14 —— 回收残留冷却液

抬高断开的软管，使残余的冷却液靠重力流回水箱。建议由两人协作完成此步骤。

### 步骤 15 —— 最终检查

确认：
- 软管已完全停止滴漏
- 现场无残留冷却液
- 设备恢复至原始状态

---

## 验收清单

| 检查项目 | 完成 |
| --- | --- |
| 补液完成 | ☐ |
| 排气完成 | ☐ |
| P2 ≥ 130 kPa | ☐ |
| 强制换泵验证通过 | ☐ |
| 残留冷却液清理完毕 | ☐ |
| 现场恢复 | ☐ |

---

## 结论

完成上述所有步骤后，BOYD RAA32-10U21 CDU 液冷回路已完成补液、排气和功能验证，可投入正常运行。
