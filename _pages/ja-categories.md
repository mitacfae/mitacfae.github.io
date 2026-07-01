---
title: "カテゴリー"
permalink: /ja/categories/
layout: archive
author_profile: true
---

{% assign ja_posts = site.posts | where: "lang", "ja" %}

{% assign all_cats = "" | split: "" %}
{% for post in ja_posts %}
  {% for cat in post.categories %}
    {% unless all_cats contains cat %}
      {% assign all_cats = all_cats | push: cat %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_cats = all_cats | sort %}

<div class="taxonomy__index">
  <ul>
    {% for cat in all_cats %}
      {% assign cat_count = 0 %}
      {% for post in ja_posts %}
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
      {% for post in ja_posts %}
        {% if post.categories contains cat %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">トップへ戻る &uarr;</a>
  </section>
{% endfor %}
