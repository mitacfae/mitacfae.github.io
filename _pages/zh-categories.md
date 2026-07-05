---
title: "文章分類"
permalink: /zh/categories/
layout: archive
author_profile: true
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}

{% assign cats_str = "" %}
{% for post in zh_posts %}
  {% for cat in post.categories %}
    {% if cats_str == "" %}
      {% assign cats_str = cat %}
    {% else %}
      {% unless cats_str contains cat %}
        {% assign cats_str = cats_str | append: "|||" | append: cat %}
      {% endunless %}
    {% endif %}
  {% endfor %}
{% endfor %}
{% assign all_cats = cats_str | split: "|||" | sort %}

<div class="taxonomy__index">
  <ul>
    {% for cat in all_cats %}
      {% assign cat_count = 0 %}
      {% for post in zh_posts %}
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

{% for cat in all_cats %}
  <section id="{{ cat | slugify }}" class="taxonomy__section">
    <h2 class="archive__subtitle">{{ cat }}</h2>
    <div class="entries-list">
      {% for post in zh_posts %}
        {% if post.categories contains cat %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">回到頂部 &uarr;</a>
  </section>
{% endfor %}
