---
layout: page
title: Categories
description: Browse all posts by category
background: '/img/bg-index.jpg'
permalink: /categories/
---

<style>

.category-index{
    display:grid;
    grid-template-columns:repeat(4,minmax(220px,1fr));
    gap:20px;
    margin:40px 0;
}

.category-card{
    border:1px solid #e5e5e5;
    border-radius:10px;
    padding:18px;
    background:#fff;
    transition:.25s;
}

.category-card:hover{
    box-shadow:0 8px 25px rgba(0,0,0,.12);
    transform:translateY(-3px);
}

.category-card h3{
    margin-top:0;
    margin-bottom:15px;
    font-size:1.2rem;
    border-bottom:1px solid #eee;
    padding-bottom:10px;
}

.category-card h3 a{
    color:#212529;
    text-decoration:none;
}

.category-card h3 a:hover{
    color:#0085A1;
}

.badge{
    display:inline-block;
    float:right;
    background:#0085A1;
    color:#fff;
    padding:2px 8px;
    border-radius:30px;
    font-size:12px;
    font-weight:bold;
}

.category-card ul{
    list-style:none;
    padding-left:0;
    margin:0;
}

.category-card li{
    padding:6px 0;
    border-bottom:1px dashed #eee;
}

.category-card li:last-child{
    border:none;
}

.category-card a{
    text-decoration:none;
}

.category-card a:hover{
    text-decoration:underline;
}

.category-section{
    margin-top:70px;
    padding-top:30px;
    border-top:2px solid #ddd;
}

.category-section h2{
    margin-bottom:25px;
}

.post-list{
    list-style:none;
    padding-left:0;
}

.post-list li{
    padding:8px 0;
}

.post-date{
    color:#999;
    font-size:14px;
    margin-right:10px;
}

.back-top{
    text-align:right;
    margin-top:25px;
}

.back-top a{
    text-decoration:none;
    font-size:14px;
}

@media(max-width:1200px){
.category-index{
grid-template-columns:repeat(3,1fr);
}
}

@media(max-width:900px){
.category-index{
grid-template-columns:repeat(2,1fr);
}
}

@media(max-width:600px){
.category-index{
grid-template-columns:1fr;
}
}

</style>

<h1 id="top">Categories</h1>

Click a category to jump directly to its articles.

<div class="category-index">

{% assign sorted_categories = site.categories | sort %}

{% for category in sorted_categories %}

<div class="category-card">

<h3>

<a href="#{{ category[0] | slugify }}">

{{ category[0] }}

</a>

<span class="badge">{{ category[1].size }}</span>

</h3>

<ul>

{% for post in category[1] limit:5 %}

<li>

<a href="{{ post.url | relative_url }}">

{{ post.title }}

</a>

</li>

{% endfor %}

{% if category[1].size > 5 %}

<li><em>More...</em></li>

{% endif %}

</ul>

</div>

{% endfor %}

</div>

<hr>

{% for category in sorted_categories %}

<div id="{{ category[0] | slugify }}" class="category-section">

<h2>

{{ category[0] }}

<span class="badge">{{ category[1].size }}</span>

</h2>

<ul class="post-list">

{% assign posts = category[1] | sort: "date" | reverse %}

{% for post in posts %}

<li>

<span class="post-date">

{{ post.date | date: "%Y-%m-%d" }}

</span>

<a href="{{ post.url | relative_url }}">

{{ post.title }}

</a>

</li>

{% endfor %}

</ul>

<div class="back-top">

<a href="#top">

↑ Back to Categories

</a>

</div>

</div>

{% endfor %}

<script>

document.addEventListener("DOMContentLoaded",function(){

const links=document.querySelectorAll('a[href^="#"]');

links.forEach(function(link){

link.addEventListener("click",function(e){

const id=this.getAttribute("href");

if(id.length>1){

const target=document.querySelector(id);

if(target){

e.preventDefault();

window.scrollTo({

top:target.offsetTop-70,

behavior:"smooth"

});

}

}

});

});

});

</script>
