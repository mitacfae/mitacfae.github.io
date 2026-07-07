---
title: "文章分类"
permalink: /zh-hans/categories/
layout: archive
author_profile: true
---

{% assign zh_hans_posts = site.posts | where: "lang", "zh-Hans" %}

{% assign all_cats = "" | split: "" %}
{% for post in zh_hans_posts %}
  {% for cat in post.categories %}
    {% unless all_cats contains cat %}
      {% assign all_cats = all_cats | push: cat %}
    {% endunless %}
  {% endfor %}
{% endfor %}

{% if all_cats.size > 0 %}
  {% assign all_cats = all_cats | sort %}
{% endif %}

{% comment %}計數表格：與英文版 /categories/ 一致的三欄 Grid 排版{% endcomment %}
<div style="display: grid !important; grid-template-columns: repeat(3, 1fr) !important; gap: 16px 40px !important; margin: 30px 0 !important; width: 100% !important; box-sizing: border-box !important;">
  {% for cat in all_cats %}
    {% assign cat_count = 0 %}
    {% for post in zh_hans_posts %}
      {% if post.categories contains cat %}
        {% assign cat_count = cat_count | plus: 1 %}
      {% endif %}
    {% endfor %}
    <div style="display: flex !important; width: 100% !important; min-width: 0 !important; box-sizing: border-box !important;">
      <a href="#{{ cat | slugify }}" class="taxonomy__item-link" style="text-decoration: none !important; display: flex !important; justify-content: space-between !important; align-items: center !important; width: 100% !important; border-bottom: 1px solid #f2f3f3 !important; padding: 4px 0 6px 0 !important; font-family: -apple-system, BlinkMacSystemFont, 'Roboto', 'Segoe UI', 'Helvetica Neue', 'Lucida Grande', Arial, sans-serif !important; font-size: 0.75em !important; transition: all 0.2s ease-in-out; box-sizing: border-box !important;">
        <span style="font-weight: 700 !important; color: #3d4144 !important; word-break: break-word !important; padding-right: 8px !important;">{{ cat }}</span>
        <span class="taxonomy__count" style="color: #8994a6 !important; font-size: 0.85em !important; font-weight: normal !important; flex-shrink: 0 !important; margin-left: auto !important; text-align: right !important;">{{ cat_count }}</span>
      </a>
    </div>
  {% endfor %}
</div>
<div style="clear: both; margin-bottom: 30px;"></div>

<style>
  .taxonomy__item-link:hover {
    border-bottom-color: #3d4144 !important;
  }
  .taxonomy__item-link:hover span {
    color: #000000 !important;
  }
</style>

{% for cat in all_cats %}
  <section id="{{ cat | slugify }}" class="taxonomy__section">
    <h2 class="archive__subtitle">{{ cat }}</h2>
    <div class="entries-list">
      {% for post in zh_hans_posts %}
        {% if post.categories contains cat %}
          {% include archive-single.html type='list' %}
        {% endif %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">回到顶部 &uarr;</a>
  </section>
{% endfor %}
