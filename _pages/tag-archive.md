---
title: "Posts by Tag"
permalink: /tags/
layout: archive
author_profile: true
---

{% assign en_posts = site.posts | where_exp: "p", "p.lang != 'zh-TW'" %}
{% assign en_posts = en_posts | where_exp: "p", "p.lang != 'zh-Hans'" %}
{% assign en_posts = en_posts | where_exp: "p", "p.lang != 'ja'" %}
{% assign en_posts = en_posts | where_exp: "p", "p.lang != 'ko'" %}


{% assign all_tags = "" | split: "" %}
{% for post in en_posts %}
  {% for tag in post.tags %}
    {% unless all_tags contains tag %}
      {% assign all_tags = all_tags | push: tag %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign all_tags = all_tags | sort %}



{% comment %}計數表格：完美校正統計數字與底線的左右對齊邊界{% endcomment %}
<div style="display: grid !important; grid-template-columns: repeat(3, 1fr) !important; gap: 16px 40px !important; margin: 30px 0 !important; width: 100% !important; box-sizing: border-box !important;">
  {% for tag in all_tags %}
    {% assign tag_count = 0 %}
    {% for post in en_posts %}
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



<style>
  /* 模擬測試網頁滑鼠移過去時的底線加深與變色效果 */
  .taxonomy__item-link:hover {
    border-bottom-color: #3d4144 !important;
  }
  .taxonomy__item-link:hover span {
    color: #000000 !important;
  }
</style>


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
