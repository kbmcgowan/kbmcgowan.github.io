---
layout: post
title:  "Easy, readable css interlinear glosses"
date:   2009-02-28 15:11:16
categories: css linguistics
---

CSS should make the creation and sharing of [standard interlinear
glosses/translations](http://www.eva.mpg.de/lingua/resources/glossing-rules.php)
easy; so far it does not.  In general, either the text entry or the
output (or both!) is absolutely unacceptable.  For example:

{% highlight html %}
<h1>John 3:16</h1>
<div class="unit"><p class="gk">οὕτως</p>
<p class="en">such</p></div>
<div class="unit"><p class="gk">γὰρ</p>
<p class="en">for</p></div>
<div class="unit"><p class="gk">ἠγάπησεν</p>
<p class="en">loved</p></div>
{% endhighlight %}

&nbsp;

Notice that any sense of these translated words having some pairwise
(let alone phrasal, clause, or sentence!) structure is completely
shrouded in the cumbersome and obtrusive markup (this would also
be a huge pain to type).  The output is admittely <strong>really</strong>
nice and allows one to do some cool things with javascript, but the
text is essentially unusable in this form.  If I wanted 4,000,000
tags per document I'd use XML/XSLT (p.s. yuck).

The goal, it seems,is something more like the entry one uses in
gb4e.sty glosses in a LaTeX document:

{% highlight latex %}
\begin{exe} 
\ex 
\gll Wenn jemand in die W\"uste zieht ... \\ 
If someone in the desert draws and lives ... \\ 
\trans ‘if one retreats to the desert and ... ’ 
\end{exe} 
{% endhighlight %}

&nbsp;

gb4e/LaTeX handle making words that are glosses of one another
line up in the display.  In short, the goal is separation of content
from display and that's the entire bloody point of CSS, right?

What I'd really like is text entry like this:

{% highlight html %}
<div class="interlinear">
<p class="source">T&aacute; ceol agam. </p>
<p class="gloss">to be-PRS music-M.PL at-1SG</p>
<p class="target">I am musical</p>
</div>
{% endhighlight %}

&nbsp;

In addition to the problem that CSS is basically incapable of doing any kind of interesting text alignment, this example introduces the complication of aligning multiple words to a single word.  What I have so far is text entry using the CSS inline-table attribute like this:

{% highlight html %}
<div class="interlinear">
<p class="gloss">
    <div class="gll">T&aacute;<br />to be-PRS</div>
    <div class="gll">ceol<br />music-M.PL</div>
    <div class="gll">agam<br />at-1SG</div>
</p>
<p class="translation">I am musical</p>
</div>
{% endhighlight %}

&nbsp;

which, I think, still totally sucks.  There's less markup than the first version so it's *slightly* better, but it's still not very good.  Two good things, though, are that the CSS is obvious, simple and standard ([interlinear.css](/css/interlinear.css)) and the output is nice:

<link rel="stylesheet" href="/css/interlinear.css">

<ol class="interlinear">
<li> Irish
    <p class="gloss">
	<div class="gll">T&aacute;<br />to be-PRS</div>
	<div class="gll">ceol<br />music-M.PL</div>
	<div class="gll">agam<br />at-1SG</div>
    </p>
    <p class="translation">I am musical</p>
</li>

<li> Latin
    <p class="gloss">
	<div class="gll">In <br /> in </div>
	<div class="gll">nomine <br /> name </div>
	<div class="gll">Patris <br /> Father </div>
	<div class="gll">et <br /> and </div>
	<div class="gll">Filii <br /> Son </div>
	<div class="gll">et <br /> and </div>
	<div class="gll">Spiritus <br /> Spirit </div>
	<div class="gll">Sancti <br /> Holy </div>
    </p>
    <p class="translation">In the name of the Father, the Son and the Holy Spirit.</p>
</li>

<li> Classical Japanese (Ariwara no Narihira courtesy E. Alpert)
    <p class="gloss">
	<div class="gll">tsuki<br /> moon</div>
	<div class="gll">ya<br /> Q</div>
	<div class="gll">aranu<br /> is-NEG</div>
	<div class="gll">haru<br /> spring</div>
	<div class="gll">ya<br /> Q</div>
	<div class="gll">mukashi<br /> long.ago</div>
	<div class="gll">no<br /> GEN</div>
	<div class="gll">haru<br /> spring</div>
	<div class="gll">naranu<br /> COP-NEG</div>
    </p>
    <p class="glt">&ldquo;Isn't this the moon? And isn't spring the way it used to be?&rdquo;</p>
</li>
</ol>

&nbsp;

I have a little javascript hack that will assemble these inline-table
divs at run time from the first type of HTML.  This allows me to
write markup in the style I want but it's gross and still doesn't
facilitate searching.  I'll update this page when I come up with
something better (or you could e-mail me if you have a better idea).
