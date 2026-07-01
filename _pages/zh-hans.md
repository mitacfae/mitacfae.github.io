---
title: "简体中文文章"
permalink: /zh-hans/
layout: archive
author_profile: true
entries_layout: list
---

{% assign zh_hans_posts = site.posts | where: "lang", "zh-Hans" %}
{% assign entries_layout = page.entries_layout | default: 'list' %}

<div class="entries-{{ entries_layout }}">
  {% include documents-collection.html entries=zh_hans_posts type=entries_layout %}
</div>
