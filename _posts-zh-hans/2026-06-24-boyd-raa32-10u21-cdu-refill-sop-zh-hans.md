---
title: "BOYD RAA32-10U21 CDU 补液 SOP"
excerpt: "BOYD RAA32-10U21 CDU 补液、排气与双泵备份验证的标准作业程序。"
lang: zh-Hans
lang_ref: boyd-cdu-refill-sop
categories:
  - sop
  - liquidcooling
tags:
  - CDU
  - BOYD
  - 液冷
  - SOP
header:
  teaser: https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg
---

本文说明 BOYD RAA32-10U21 CDU 补液、排气，以及双泵备份切换验证的标准作业程序，确保液冷回路能在稳定压力下正常运作。

## 概述

执行 BOYD RAA32-10U21 CDU 补液与启用作业时，请依下列步骤进行：

1. **接上补水与排气管线** — 将管线分别接至 CDU 的 `COOLANT FILLING` 与 `EXHAUST PORT` 接口，两条管线末端皆需浸入外部冷却液储水槽中。
2. **启动补水泵** — 自外部储水槽吸入冷却液并排除回路中的空气。
3. **启动 CDU 并确认压力** — 确认次级回路回水压力（P2）达到验收标准。
4. **验证泵备份** — 执行强制泵切换，确认双泵备份切换机制正常运作。

> **注意：** CDU 运转后，`EXHAUST PORT` 接口可能仍存在残压。务必先定位管路，再对接接口，以避免气体释放或冷却液喷溅。

---

## 使用设备清单

| 项目 | 数量 |
| --- | --- |
| G4520G6 服务器 | 1 |
| BOYD RAA32-10U21 CDU | 1 |
| 外部冷却液储水桶 | 1 |
| 补水管线（进水＋排气） | 2 |
| 抹布 | 1 条以上 |
| 个人防护装备（PPE） | 依需求 |

---

## 安全注意事项

### EXHAUST PORT 残压风险

CDU 后方的 `EXHAUST PORT` 接口可能存在系统残压。

为避免接口时发生气体释放或流体喷溅：
> 务必先定位管路，再对接接口，不可颠倒顺序。

### 补液期间管线跳脱风险

执行补液作业时，流体排出之动能冲击可能导致补水管线跳脱容器。

请于储水桶孔径处以抹布紧密填塞，避免管线脱离容器。

### 系统配置

将服务器端与 CDU 建立完整的次级液冷回路（Secondary Liquid Cooling Loop），形成闭合循环系统。

---

## 补液流程

### Step 1 — 确认电源

CDU 电源接好并确认电力供应正常。

### Step 2 — 接上排气管线

移除 CDU 后侧 `EXHAUST PORT` 黑色外盖，并接上第一条快速接头水管。管线末端须全程置于外部冷却液储水槽中，以避免冷却液外漏。

![BOYD RAA32-10U21 CDU 后方 EXHAUST PORT 接口](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/exhaust-port.jpeg)

### Step 3 — 接上补水管线

移除 CDU 后侧 `COOLANT FILLING` 黑色外盖，并接上第二条快速接头水管。管线末端同样须全程置于外部冷却液储水槽中。

![BOYD RAA32-10U21 CDU 后方 COOLANT FILLING 接口](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/coolant-filling-port.jpeg)

### Step 4 — 确认接口定义

| 接口 | 说明 |
| --- | --- |
| `INT` | 系统补水埠（`COOLANT FILLING`） |
| `EXT` | 系统出水埠（`EXHAUST PORT`） |

系统运转时，将自外部容器主动吸入冷却液以进行系统充液。

![CDU 与外部冷却液储水槽之 INT / EXT 管线连接示意图](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/int-ext-connection.png)

### Step 5 — 启动补水泵

于 CDU 触控面板开启 **Refill Pump**。

![CDU Operating Setpoint 画面之 Refill Pump ON/OFF 开关](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/refill-pump-onoff.jpeg)

### Step 6 — 排除空气

观察 `EXHAUST PORT` 是否仍有气泡排出。确认无气泡后，将快速接头解除锁定，但无需完全拔除。

### Step 7 — 完成补液

补水泵会在完成充液后自行停止运作。

若服务器与 CDU 内部先前已预填冷却液：
- 排气与补水程序大约耗时 **3 至 5 分钟**
- 请目视确认夹带空气已完全排出

### Step 8 — 启动 CDU

启动 CDU。

### Step 9 — 确认回水压力

监测系统状态画面之 **Return Pressure（P2）**。

![CDU System Status 画面之 Return Press P2 数值](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/return-pressure-p2.jpeg)

#### 验收标准

- P2 ≥ 130 kPa

#### 备注

开机初期运转约 1～2 分钟内，数值可能出现暂态下降。请等待系统稳定后，再进行最终判定。

### Step 10 — 压力未达标处理

若 P2 未达 130 kPa，请执行以下步骤：

1. 关闭 CDU
2. 启动 Refill Pump
3. 等待自动补水完成
4. 回到 Step 8

### Step 11 — 验证泵备份

执行 **Force Pump Switch**，确认双泵备份切换机制正常运作。

![CDU Operating Setpoint 画面之 Force Pump Switch 控制项](https://blog.mitacfae.com/assets/images/sop/liquidcooling/boyd-raa32-10u21-cdu-refill-sop/force-pump-switch.jpeg)

### Step 12 — 关闭系统

关闭 CDU。

### Step 13 — 拆除管线

拆卸 `EXHAUST PORT` 与 `COOLANT FILLING` 两条补水管线。解除快速接头时可能伴随微量残液溢漏，如有泄漏请立即以抹布擦干。

### Step 14 — 回收残液

管线接头脱开后，抬高管线利用重力将残液流回储水槽，并注意管线末端不脱离储水槽。建议全程采双人协同作业，以确保安全。

### Step 15 — 收尾检查

确认：
- 管线已完全滴干
- 现场无残留液体
- 装置已恢复原始状态

---

## 验收检查表

| 检查项目 | 完成 |
| --- | --- |
| 补液完成 | ☐ |
| 排气完成 | ☐ |
| P2 ≥ 130 kPa | ☐ |
| Force Pump Switch 验证完成 | ☐ |
| 残液清除完成 | ☐ |
| 现场整理完成 | ☐ |

---

## 结语

完成以上步骤后，即可确认 BOYD RAA32-10U21 CDU 液冷回路已完成补液、排气及功能验证，可投入正常运转。
