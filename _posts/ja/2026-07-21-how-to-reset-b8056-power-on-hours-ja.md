---
title: "B8056 の稼働時間 (Power-On Hours) をリセットする方法"
excerpt: "この記事では、Linux スクリプトから ipmitool コマンドを実行して、B8056 プラットフォームの Power-On Hours (POH) カウンターをリセットする方法を説明します。"
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
lang: ja
lang_ref: how-to-reset-b8056-power-on-hours
toc: true
toc_label: "目次"
toc_sticky: true
header:
  teaser: /assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png
---

この記事では、B8056 プラットフォームの **Power-On Hours (POH)** カウンターをリセットする方法を説明します。POH の値は、内部で `ipmitool` コマンドを BMC に送信するラッパースクリプトを Linux ホスト上で実行することでクリアできます。

## 概要

B8056 の Power-On Hours カウンターは、内部で `ipmitool` を呼び出す Linux シェルスクリプトを使ってリセットできます。ボード交換後やバーンインテストの後、あるいは出荷前・再稼働前に累積した POH 値をクリアする必要がある場面で役立ちます。

![リセット前に BMC 上に表示される Power-On Hours の値](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-before-reset.png)

---

## 前提条件

| 項目           | 要件                                          |
| -------------- | --------------------------------------------- |
| ツール         | `8056_clear_poh.sh` スクリプト（`ipmitool` のラッパー） |
| ネットワーク   | BMC の IP アドレスに到達できること            |
| 認証情報       | 有効な BMC ユーザー名とパスワード             |
| 実行環境       | `ipmitool` がインストールされた Linux ホスト  |

---

## 手順

### コマンド

Linux 環境でスクリプトを実行し、BMC のユーザー名、パスワード、IP アドレスを引数として渡します。

```
./8056_clear_poh.sh {BMC_username} {BMC_password} {BMC_IP_Address}
```

`{BMC_username}`、`{BMC_password}`、`{BMC_IP_Address}` は対象システムの実際の値に置き換えてください。

### 実行例

```
$ ./8056_clear_poh.sh root tyan@123 10.99.238.73
```

![対象の BMC に対して POH クリアスクリプトを実行した例](/assets/images/bmc/how-to-reset-b8056-power-on-hours/script-execution-example.png)


[Download 8056_clear_poh.sh](/assets/files/bmc/how-to-reset-b8056-power-on-hours/8056_clear_poh.sh)

### 結果

スクリプトの実行が完了すると、Power-On Hours カウンターがクリアされ、再取得時にはリセットされた状態として表示されます。

![スクリプト実行後、Power-On Hours がリセットされたことを確認](/assets/images/bmc/how-to-reset-b8056-power-on-hours/poh-after-reset.png)

---

## リセット後

システムを稼働に戻す前に、BMC の Web GUI または `ipmitool` から POH の値がゼロ（または想定どおりの基準値）になっていることを確認してください。

> **注意：** この操作は累積された Power-On Hours カウンターのみをクリアするものであり、BMC のネットワーク設定、ユーザーアカウント、その他のセンサーログには影響しません。
