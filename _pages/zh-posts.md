---
title: "文章列表"
permalink: /zh/posts/
layout: archive
author_profile: true
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}

{% assign postsByYear = zh_posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in postsByYear %}
  <h2 id="{{ year.name }}" class="archive__subtitle">{{ year.name }}</h2>
  {% for post in year.items %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
