---
title: "Posts by Year"
permalink: /posts/
layout: archive
author_profile: true
---

{% assign filtered_posts = site.posts | where_exp: "p", "p.lang != 'zh-TW' and p.lang != 'zh-Hans' and p.lang != 'ja' and p.lang != 'ko'" %}

{% assign postsByYear = filtered_posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in postsByYear %}
  <h2 id="{{ year.name }}" class="archive__subtitle">{{ year.name }}</h2>
  {% for post in year.items %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
