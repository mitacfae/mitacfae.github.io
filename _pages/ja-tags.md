---
title: "タグ"
permalink: /ja/tags/
layout: archive
author_profile: true
---

{% assign ja_posts = site.posts | where: "lang", "ja" %}

{% assign all_tags = "" | split: "" %}
{% for post in ja_posts %}
  {% for tag in post.tags %}
    {% unless all_tags contains tag %}
      {% assign all_tags = all_tags | push: tag %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_tags = all_tags | sort %}

<div class="taxonomy__index">
  <ul>
    {% for tag in all_tags %}
      {% assign tag_count = 0 %}
      {% for post in ja_posts %}
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
      {% for post in ja_posts %}
        {% if post.tags contains tag %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">トップへ戻る &uarr;</a>
  </section>
{% endfor %}
