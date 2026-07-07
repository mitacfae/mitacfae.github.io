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
    {% if tags_str == "" %}
      {% assign tags_str = tag %}
    {% else %}
      {% unless tags_str contains tag %}
        {% assign tags_str = tags_str | append: "|||" | append: tag %}
      {% endunless %}
    {% endif %}
  {% endfor %}
{% endfor %}
{% assign all_tags = tags_str | split: "|||" | sort %}

{% comment %}計數表格：與英文版 /tags/ 一致的三欄 Grid 排版{% endcomment %}
<div style="display: grid !important; grid-template-columns: repeat(3, 1fr) !important; gap: 16px 40px !important; margin: 30px 0 !important; width: 100% !important; box-sizing: border-box !important;">
  {% for tag in all_tags %}
    {% assign tag_count = 0 %}
    {% for post in zh_posts %}
      {% if post.tags contains tag %}
        {% assign tag_count = tag_count | plus: 1 %}
      {% endif %}
    {% endfor %}
    <div style="display: flex !important; width: 100% !important; min-width: 0 !important; box-sizing: border-box !important;">
      <a href="#{{ tag | slugify }}" class="taxonomy__item-link" style="text-decoration: none !important; display: flex !important; justify-content: space-between !important; align-items: center !important; width: 100% !important; border-bottom: 1px solid #f2f3f3 !important; padding: 4px 0 6px 0 !important; font-family: -apple-system, BlinkMacSystemFont, 'Roboto', 'Segoe UI', 'Helvetica Neue', 'Lucida Grande', Arial, sans-serif !important; font-size: 0.75em !important; transition: all 0.2s ease-in-out; box-sizing: border-box !important;">
        <span style="font-weight: 700 !important; color: #3d4144 !important; word-break: break-word !important; padding-right: 8px !important;">{{ tag }}</span>
        <span class="taxonomy__count" style="color: #8994a6 !important; font-size: 0.85em !important; font-weight: normal !important; flex-shrink: 0 !important; margin-left: auto !important; text-align: right !important;">{{ tag_count }}</span>
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
