---
title: "文章標籤"
permalink: /zh/tags/
layout: archive
author_profile: true
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}

{% assign all_tags = "" | split: "" %}
{% for post in zh_posts %}
  {% for tag in post.tags %}
    {% unless all_tags contains tag %}
      {% assign all_tags = all_tags | push: tag %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_tags = all_tags | sort %}

{% for tag in all_tags %}
  <h2 id="{{ tag | slugify }}" class="archive__subtitle">{{ tag }}</h2>
  {% for post in zh_posts %}
    {% if post.tags contains tag %}
      {% include archive-single.html %}
    {% endif %}
  {% endfor %}
{% endfor %}
