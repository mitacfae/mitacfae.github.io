---
title: "文章標籤"
permalink: /zh/tags/
layout: archive
author_profile: true
---

{% assign zh_posts = site.posts | where: "lang", "zh-TW" %}

{% assign tags_str = "" %}
{% for post in zh_posts %}
  {% for tag in post.tags %}
    {% assign needle = "|||" | append: tag | append: "|||" %}
    {% assign haystack = "|||" | append: tags_str | append: "|||" %}
    {% if tags_str == "" %}
      {% assign tags_str = tag %}
    {% elsif haystack contains needle %}
      {# 標籤已存在，略過 #}
    {% else %}
      {% assign tags_str = tags_str | append: "|||" | append: tag %}
    {% endif %}
  {% endfor %}
{% endfor %}
{% assign all_tags = tags_str | split: "|||" | sort_natural %}

<div class="taxonomy__index">
  <ul>
    {% for tag in all_tags %}
      {% assign tag_count = 0 %}
      {% for post in zh_posts %}
        {% if post.tags contains tag %}
          {% assign tag_count = tag_count | plus: 1 %}
        {% endif %}
      {% endfor %}
      <li>
        <a href="#{{ tag | slugify }}">
          <strong>{{ tag }}</strong> <span class="taxonomy__count">{{ tag_count }}</span>
        </a>
      </li>
    {% endfor %}
  </ul>
</div>

{% for tag in all_tags %}
  <section id="{{ tag | slugify }}" class="taxonomy__section">
    <h2 class="archive__subtitle">{{ tag }}</h2>
    <div class="entries-list">
      {% for post in zh_posts %}
        {% if post.tags contains tag %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">回到頂部 &uarr;</a>
  </section>
{% endfor %}
