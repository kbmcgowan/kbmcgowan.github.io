---
layout: post
title:  "What's 1000 words worth?"
date:   2010-07-14 15:11:16
categories: information
---

Let's randomly select 1,000 lines from the dictionary and appends
the number of bytes in that sample to a file.

{% highlight bash %}
for i in {1..500}; do
    awk 'BEGIN {srand()} {printf "%05.0f %s \n",rand()*99999, $0; }' /usr/share/dict/words | sort -n |\\
    head -1000 | sed 's/^[0-9]* //' | dd 2>&1 | grep "bytes transferred" | awk '{print $1}' >>sizes.dat
done
{% endhighlight %}

&nbsp;

then, in R:

&nbsp;

{% highlight rconsole %}
> sizes <- read.table("~/sizes.dat", header=TRUE)
> mean(sizes)
   bytes 
11581.83 
> sd(sizes)
   bytes 
90.32316 
> qqnorm(sizes$bytes)
> plot(density(sizes$bytes))
> hist(sizes$bytes, col=rainbow(15, start=.4))
> mean(sizes$bytes) / 1024
[1] 11.31038
{% endhighlight %}

&nbsp;

11.31k is not a very large picture. Each of the exploratory plots ([quantile x normal](/blog/assets/lj/words-qqnorm.png), [density](/blog/assets/lj/words-density.png), [histogram](/blog/assets/lj/words-hist.png)) is larger! Even these pictures of me and my daughter and the fat giraffes are 13k, 13k, and 15k respectively:

![13k](/blog/assets/lj/2008-07-02-fg2-th.jpg)
![13k](/blog/assets/lj/2008-07-02-fg3-th.jpg)
![15k](/blog/assets/lj/2008-07-02-fg5-th.jpg)

Still, [here are all the many, many google image hits for 'entropy' pictures that are 128 x 128 pixels](http://images.google.com/images?as_q=entropy&hl=en&btnG=Google+Search&as_epq=&as_oq=&as_eq=&as_sitesearch=&as_st=y&tbs=isch:1,isz:ex,iszw:128,iszh:128).  Many of these are are in the roughly 11k range. 

Happy Bastille Day.
