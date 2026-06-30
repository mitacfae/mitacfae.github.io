---
title: "历年文章"
permalink: /zh-hans/posts/
layout: archive
author_profile: true
---

{% assign filtered_posts = site.posts | where: "lang", "zh-Hans" %}

{% assign postsByYear = filtered_posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in postsByYear %}
  <h2 id="{{ year.name }}" class="archive__subtitle">{{ year.name }}</h2>
  {% for post in year.items %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
