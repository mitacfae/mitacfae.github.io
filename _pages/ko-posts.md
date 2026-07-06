---
title: "연도별 게시글"
permalink: /ko/posts/
layout: archive
author_profile: true
---

{% assign filtered_posts = site.posts | where: "lang", "ko" %}

{% assign postsByYear = filtered_posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in postsByYear %}
  <h2 id="{{ year.name }}" class="archive__subtitle">{{ year.name }}</h2>
  {% for post in year.items %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
