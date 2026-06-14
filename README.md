# addlegend
Stata utility to add a custom legend to a twoway graph

`addlegend` is a utility to create a custom legend and add it to a twoway
graph. In contrast to Stata's `legend()` option, `addlegend` can combine
multiple symbols in a single legend key, and the keys can be freely positioned
on the plot.

To install `addlegend` from GitHub, type

    . net install addlegend, replace from(https://raw.githubusercontent.com/benjann/addlegend/main/)

`addlegend` requires [`addplot`](https://doi.org/10.1177/1536867X1501500308). To install
`addplot`, type

    . ssc install addplot, replace

---

Examples

**Composite symbols**
The following example illustrates how to create a composite symbol.

    sysuse auto
    twoway (sc mpg turn, msize(large) ms(Oh)) ///
           (sc mpg turn, msize(large) ms(X) pstyle(p1)) ///
           (lfit mpg turn, pstyle(p2))
    addlegend, X(45) frame: ///
           (Oh X, msize(large)) "Mileage (mpg)" ///
        || (line)               "Fitted values"

Option `X(45)` has been used to shift the legend to the right of the
graph (the left edge of the space allocated for the keys' symbols is positioned
at X = 45). By default, the legend is placed in the top-left corner.

![example 1](/images/1.png)

**Custom positioning of legend keys**
The following example illustrates how the legend keys can be placed in different
locations on the plot.

    sysuse auto
    twoway (histogram weight if foreign==0, psty(p1bar) color(%50)) ///
           (histogram weight if foreign==1, psty(p2bar) color(%50))
    addlegend, lskip(0) color(%50): ///
           (bar) "Domestic", X(4840) W(-300) ///
        || (bar) "Foreign", X(1760) W(300)

Note how setting the symbol width to a negative value changes the default
placement of the key's text.

![example 2](/images/2.png)

**Headings**
The following example illustrates how headings aligned with the keys' symbols
or aligned with the keys' texts can be added.

    sysuse uslifeexp
    twoway (connect le_f le_m year)
    addlegend: ///
           "Heading aligned with symbol" ///
        || (line) () "female" ///
        || - "Heading aligned with text" ///
        || (line) () "male"

![example 3](/images/3.png)

**Placing the legend outside of the plot region**
If you want to place the legend outside of the plot region, use the `margin()`
option to make sure that there is enough space for the legend in the graph's
margin.

    sysuse auto
    twoway (sc mpg turn, msize(large) ms(Oh)) ///
           (sc mpg turn, msize(large) ms(X) pstyle(p1)) ///
           (lfit mpg turn, pstyle(p2))
    addlegend, x(105) margin(r=40): ///
           (Oh X, msize(large)) "Mileage (mpg)" ///
        || (line) "Fitted values"

![example 4](/images/4.png)

**Add legend to subgraph** 
In case of a graph that contains multiple subgraphs, specify `addlegend _#_`
to select the subgraph to which the legend should be added:

    sysuse auto
    scatter mpg trunk weight, legend(off) name(weight, replace) nodraw
    scatter mpg trunk price, legend(off) name(price, replace) nodraw
    graph combine weight price
    addlegend 2, x(60) tw(35) frame: ///
           () "Mileage per gallon" ///
        || () "Trunk space"

![example 5](/images/5.png)

---

Main changes:

    14jun2026 (version 2.0.0)
    - package relaunched as addlegend; command mklegend renamed to _mklegend
    - settings such as height and width are now specified in percent of the
      sizes of the axes of the existing graph; capital-letter syntax can be
      used to specify settings in original units
    - dimexp syntax discontinued; graph and subgraph now specified as
      arguments, not options
    - implementation of frame() improved
    - various settings are now returned in r()
    - lskip() now only allowed at global level
    - symbol rcap is now allowed as synonym for cap, rcapsym for capsym, spike for
      line

    07jun2026
    - command -addlegend- added

    06jun2026 (version 1.0.1)
    - areas were not plotted correctly in Stata 14; this is fixed

    06jun2026 (version 1.0.0)
    - released as mklegend on GitHub