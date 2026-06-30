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


{% comment %}計數表格：微調字體大小與左側個人簡介一致{% endcomment %}
<div style="display: grid !important; grid-template-columns: repeat(3, 1fr) !important; gap: 16px 30px !important; margin: 30px 0 !important; width: 100% !important; box-sizing: border-box !important;">
  {% for tag in all_tags %}
    {% assign tag_count = 0 %}
    {% for post in en_posts %}
      {% if post.tags contains tag %}
        {% assign tag_count = tag_count | plus: 1 %}
      {% endif %}
    {% endfor %}
    <div style="display: flex !important; align-items: baseline !important; gap: 8px !important; width: 100% !important; min-width: 0 !important; word-break: break-word !important; line-height: 1.4 !important;">
      <a href="#{{ tag | slugify }}" style="text-decoration: none !important; color: inherit !important; display: inline-flex !important; align-items: baseline !important; gap: 6px !important; min-width: 0 !important; width: 100% !important; font-size: 0.75em !important;">
        <span style="flex-shrink: 1 !important; font-weight: 600 !important; color: #49515d !important;">{{ tag }}</span> 
        <span class="taxonomy__count" style="color: #8994a6 !important; font-size: 0.85em !important; flex-shrink: 0 !important;">{{ tag_count }}</span>
      </a>
    </div>
  {% endfor %}
</div>
<div style="clear: both; margin-bottom: 30px;"></div>




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
