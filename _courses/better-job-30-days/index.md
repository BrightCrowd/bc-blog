---
layout: course
title: Networking your way to a better job in 30 days
categories: course
permalink: /courses/thirty-day-bootcamp/index.html
---


{% for item in site.courses %}
{% if item.categories contains 'lesson' %}
## {{ item.title }}
{{ item.excerpt }}
<a href="{{ item.url }}">{{ item.title }}</a>
{% endif %}
{% endfor %}
