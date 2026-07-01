---
title: "日本語の記事"
permalink: /ja/
layout: archive
author_profile: true
entries_layout: list
---

{% assign ja_posts = site.posts | where: "lang", "ja" %}
{% assign entries_layout = page.entries_layout | default: 'list' %}

<div class="entries-{{ entries_layout }}">
  {% include documents-collection.html entries=ja_posts type=entries_layout %}
</div>
