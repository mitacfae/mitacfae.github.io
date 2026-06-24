---
title: "中文文章"
permalink: /zh/
layout: archive
author_profile: true
entries_layout: list
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}
{% assign entries_layout = page.entries_layout | default: 'list' %}

<div class="entries-{{ entries_layout }}">
  {% include documents-collection.html entries=zh_posts type=entries_layout %}
</div>
