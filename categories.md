---
layout: page
title: "Categories"
description: "文章分類目錄"
permalink: /categories/
---

<div class="category-tags" style="margin-bottom: 30px;">
  {% for category in site.categories %}
    <a href="#{{ category | first | slugify }}" class="btn btn-outline-secondary btn-sm" style="margin: 5px;">
      {{ category | first }} ({{ category | last | size }})
    </a>
  {% endfor %}
</div>

<hr>

<div class="category-lists">
  {% for category in site.categories %}
    <div id="{{ category | first | slugify }}" class="category-section" style="margin-top: 40px;">
      <h3 style="border-bottom: 2px solid #0085a1; padding-bottom: 10px;">
        <i class="fa fa-folder-open"></i> {{ category | first }}
      </h3>
      <ul style="list-style-type: none; padding-left: 10px;">
        {% for post in category.last %}
          <li style="margin: 10px 0;">
            <span style="color: #808080; font-size: 0.9em; margin-right: 15px;">{{ post.date | date: "%Y-%m-%d" }}</span>
            <a href="{{ post.url | relative_url }}" style="font-weight: 500; font-size: 1.1em; color: #333; text-decoration: none;">{{ post.title }}</a>
          </li>
        {% endfor %}
      </ul>
    </div>
  {% endfor %}
</div>
