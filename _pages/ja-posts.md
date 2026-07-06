---
title: "年別の投稿"
permalink: /ja/posts/
layout: archive
author_profile: true
---

{% assign filtered_posts = site.posts | where: "lang", "ja" %}

{% assign postsByYear = filtered_posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in postsByYear %}
  <h2 id="{{ year.name }}" class="archive__subtitle">{{ year.name }}</h2>
  {% for post in year.items %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
