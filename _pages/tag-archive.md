---
title: "Posts by Tag"
permalink: /tags/
layout: archive
author_profile: true
---

{% assign en_posts = site.posts | where_exp: "p", "p.lang != 'zh-TW'" %}

{% assign all_tags = "" | split: "" %}
{% for post in en_posts %}
  {% for tag in post.tags %}
    {% unless all_tags contains tag %}
      {% assign all_tags = all_tags | push: tag %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_tags = all_tags | sort %}

{% comment %}計數表格{% endcomment %}
<div class="taxonomy__index">
  <ul style="display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 24px 30px; list-style: none; padding-left: 0; line-height: 1.5;">
    {% for tag in all_tags %}
      {% assign tag_count = 0 %}
      {% for post in en_posts %}
        {% if post.tags contains tag %}
          {% assign tag_count = tag_count | plus: 1 %}
        {% endif %}
      {% endfor %}
      <li style="margin: 0; padding: 4px 0;">
        <a href="#{{ tag | slugify }}" style="text-decoration: none;">
          <strong>{{ tag }}</strong> <span class="taxonomy__count" style="margin-left: 4px;">{{ tag_count }}</span>
        </a>
      </li>
    {% endfor %}
  </ul>
</div>


{% comment %}各 tag 的文章列表（含 excerpt）{% endcomment %}
{% for tag in all_tags %}
  <section id="{{ tag | slugify }}" class="taxonomy__section">
    <h2 class="archive__subtitle">{{ tag }}</h2>
    <div class="entries-list">
      {% for post in en_posts %}
        {% if post.tags contains tag %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">{{ site.data.ui-text[site.locale].back_to_top | default: 'Back to Top' }} &uarr;</a>
  </section>
{% endfor %}
