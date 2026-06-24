---
title: "Posts by Category"
permalink: /categories/
layout: archive
author_profile: true
---

{% assign en_posts = site.posts | where_exp: "p", "p.lang != 'zh-TW'" %}

{% comment %}建立 category -> posts 的對應{% endcomment %}
{% assign all_cats = "" | split: "" %}
{% for post in en_posts %}
  {% for cat in post.categories %}
    {% unless all_cats contains cat %}
      {% assign all_cats = all_cats | push: cat %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_cats = all_cats | sort %}

{% comment %}計數表格{% endcomment %}
<div class="taxonomy__index">
  {% assign rows = all_cats | size | divided_by: 3.0 | ceil %}
  <ul>
    {% for cat in all_cats %}
      {% assign cat_count = 0 %}
      {% for post in en_posts %}
        {% if post.categories contains cat %}
          {% assign cat_count = cat_count | plus: 1 %}
        {% endif %}
      {% endfor %}
      <li>
        <a href="#{{ cat | slugify }}">
          <strong>{{ cat }}</strong> <span class="taxonomy__count">{{ cat_count }}</span>
        </a>
      </li>
    {% endfor %}
  </ul>
</div>

{% comment %}各 category 的文章列表（含 excerpt）{% endcomment %}
{% for cat in all_cats %}
  <section id="{{ cat | slugify }}" class="taxonomy__section">
    <h2 class="archive__subtitle">{{ cat }}</h2>
    <div class="entries-list">
      {% for post in en_posts %}
        {% if post.categories contains cat %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">{{ site.data.ui-text[site.locale].back_to_top | default: 'Back to Top' }} &uarr;</a>
  </section>
{% endfor %}
