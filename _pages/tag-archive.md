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
  <ul style="display: grid !important; grid-template-columns: repeat(3, 1fr) !important; gap: 20px 40px !important; list-style: none !important; padding: 0 !important; margin: 0 !important; width: 100% !important;">
    {% for tag in all_tags %}
      {% assign tag_count = 0 %}
      {% for post in en_posts %}
        {% if post.tags contains tag %}
          {% assign tag_count = tag_count | plus: 1 %}
        {% endif %}
      {% endfor %}
      <li style="display: block !important; float: none !important; width: auto !important; margin: 0 !important; padding: 0 !important; min-width: 0 !important; word-break: break-word !important; line-height: 1.4 !important;">
        <a href="#{{ tag | slugify }}" style="text-decoration: none !important; display: flex !important; align-items: baseline !important; gap: 6px !important; width: 100% !important;">
          <strong style="flex-shrink: 1 !important;">{{ tag }}</strong> 
          <span class="taxonomy__count" style="color: #8994a6 !important; font-size: 0.8em !important; flex-shrink: 0 !important;">{{ tag_count }}</span>
        </a>
      </li>
    {% endfor %}
  </ul>
</div>
<div style="clear: both;"></div>


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
