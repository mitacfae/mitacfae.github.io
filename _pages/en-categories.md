---
title: "Posts by Category"
permalink: /categories/
layout: archive
author_profile: true
---


{% assign en_posts = site.posts | where_exp: "p", "p.lang != 'zh-TW'" %}
{% assign en_posts = en_posts | where_exp: "p", "p.lang != 'zh-Hans'" %}
{% assign en_posts = en_posts | where_exp: "p", "p.lang != 'ja'" %}
{% assign en_posts = en_posts | where_exp: "p", "p.lang != 'ko'" %}

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

{% comment %}置頂分類：How to, KBase, SOP，不分大小寫比對{% endcomment %}
{% assign priority_names = "how to,kbase,sop" | split: "," %}
{% assign priority_cats = "" | split: "" %}
{% for name in priority_names %}
  {% for cat in all_cats %}
    {% assign cat_lc = cat | downcase %}
    {% if cat_lc == name %}
      {% assign priority_cats = priority_cats | push: cat %}
    {% endif %}
  {% endfor %}
{% endfor %}

{% comment %}其餘分類：扣掉已置頂的，維持原本排序{% endcomment %}
{% assign remaining_cats = "" | split: "" %}
{% for cat in all_cats %}
  {% assign cat_lc = cat | downcase %}
  {% unless priority_names contains cat_lc %}
    {% assign remaining_cats = remaining_cats | push: cat %}
  {% endunless %}
{% endfor %}

{% assign ordered_cats = priority_cats | concat: remaining_cats %}

{% comment %}計數表格：完全同步 tag-archive.md 最終修正版的 3 欄對齊格式{% endcomment %}
<div style="display: grid !important; grid-template-columns: repeat(3, 1fr) !important; gap: 16px 40px !important; margin: 30px 0 !important; width: 100% !important; box-sizing: border-box !important;">
  {% for cat in ordered_cats %}
    {% assign cat_count = 0 %}
    {% for post in en_posts %}
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
  /* 滑鼠移過去時的底線加深與文字變色效果 */
  .taxonomy__item-link:hover {
    border-bottom-color: #3d4144 !important;
  }
  .taxonomy__item-link:hover span {
    color: #000000 !important;
  }
</style>

{% comment %}各 category 的文章列表（含 excerpt）{% endcomment %}
{% for cat in ordered_cats %}
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
