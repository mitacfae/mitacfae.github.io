---
title: "文章分類"
permalink: /zh/categories/
layout: archive
author_profile: true
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}

{% assign all_cats = "" | split: "" %}
{% for post in zh_posts %}
  {% for cat in post.categories %}
    {% unless all_cats contains cat %}
      {% assign all_cats = all_cats | push: cat %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_cats = all_cats | sort %}

{% for cat in all_cats %}
  <h2 id="{{ cat | slugify }}" class="archive__subtitle">{{ cat }}</h2>
  {% for post in zh_posts %}
    {% if post.categories contains cat %}
      {% include archive-single.html %}
    {% endif %}
  {% endfor %}
{% endfor %}
