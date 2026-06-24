---
title: "中文文章"
permalink: /zh/
layout: archive
author_profile: true
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}

{% if zh_posts.size > 0 %}
  {% for post in zh_posts %}
    <div class="list__item">
      <article class="archive__item" itemscope itemtype="https://schema.org/CreativeWork">
        <h2 class="archive__item-title" itemprop="headline">
          <a href="{{ post.url | relative_url }}" rel="permalink">{{ post.title }}</a>
        </h2>
        {% if post.excerpt %}
          <p class="archive__item-excerpt" itemprop="description">{{ post.excerpt | strip_html | truncate: 160 }}</p>
        {% endif %}
      </article>
    </div>
  {% endfor %}
{% else %}
  <p>目前還沒有中文文章。</p>
{% endif %}
