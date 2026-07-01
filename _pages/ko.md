---
title: "한국어 게시글"
permalink: /ko/
layout: archive
author_profile: true
entries_layout: list
---

{% assign ko_posts = site.posts | where: "lang", "ko" %}
{% assign entries_layout = page.entries_layout | default: 'list' %}

<div class="entries-{{ entries_layout }}">
  {% include documents-collection.html entries=ko_posts type=entries_layout %}
</div>
