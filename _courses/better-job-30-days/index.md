---
layout: course
title: The 30 Day Networking Challenge
subtitle: Networking is Super Awkward
categories: course
permalink: /courses/better-job-30-days/index.html
---

We get it. Nobody loves to network.

But it remains the absolute best way to find a new job, or to just figure out your career.

![Luke Skywalker says Nooooo](https://media.giphy.com/media/tOwCobNerbLJ6/giphy.gif)

We know, we know. It’s seriously hard to go outside your comfort zone...but it’s seriously worth it, too.

BrightCrowd is here for you — that’s why we’ve created a **4 week email course that will take you from zero to networking hero**.

It’ll have you meeting new people in your industry and sharing your story (with confidence) in 4 weeks.

**Take the challenge, and in just 30 days you’ll**:
- Learn how to tell a compelling career story.
- Make your resume and cover letter shine.
- Improve your online presence so people will be happy to meet you.
- Reach out to alumni and industry connections.
- Actually have productive conversations with new people (revolutionary, right?)  

You won’t do it alone. In three emails a week (full of checklists, straightforward assignments, and encouragement), we will show you the way.



{% for item in site.courses %}
{% if item.categories contains 'lesson' %}
> ## <a href="{{site.baseurl}}{{ item.url }}">{{ item.title }}</a>
> {{ item.excerpt | strip_html }}

{% endif %}
{% endfor %}
