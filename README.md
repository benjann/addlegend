# addlegend
Stata module to add a custom legend to a twoway graph

`addlegend` is a utility to create a custom legend and add it to a `twoway`
graph. In contrast to Stata's `legend()` option, `addlegend` can combine
multiple symbols in a single legend key, and the keys can be freely positioned
on the plot.

`addlegend` requires Stata version 14 (or newer) and
[`addplot`](https://doi.org/10.1177/1536867X1501500308). To install
`addlegend` and `addplot` from the SSC Archive, type

    . ssc install addlegend, replace
    . ssc install addplot, replace

---

Installation from GitHub:

    . net install addlegend, replace from(https://raw.githubusercontent.com/benjann/addlegend/main/)
    . net install addplot, replace from(https://raw.githubusercontent.com/benjann/addplot/main/)

---

Examples

**Composite symbols.**
The following example illustrates how to create a composite symbol.

    sysuse auto
    two (sc mpg turn, msize(large) ms(Oh)) ///
        (sc mpg turn, msize(large) ms(X) pstyle(p1)) ///
        (lfit mpg turn, pstyle(p2))
    addlegend, position(2) frame: ///
        (Oh X) "Mileage (mpg)", msize(large) ///
        (line) "Fitted values"

Option `position(2)` has been used to place the legend in the top-right corner of
the plot region.

![example 1](/images/1.png)

Use repeated parentheses if you want to apply separate options to the
individual components of a composite symbol.

    sysuse auto
    lpoly weight length, degree(1) ci
    addlegend: ///
        () "data" ///
        (area, astyle(ci)) (line) "lpoly smooth and 95% CI"

Note that specifying a key's symbol as `()` selects the plot's default
marker symbol.

![example 2](/images/2.png)

You can also include arbitrary text in a key's symbol:

    sysuse auto
    generate str ball = cond(foreign, "`=uchar(9917)'", "`=uchar(9918)'")
    scatter price weight, msymbol(i) mlabposition(0) mlabel(ball)
    addlegend: ///
        ("`=uchar(9918)'") "domestic" ///
        ("`=uchar(9917)'") "foreign"

![example 7](/images/7.png)

**Custom positioning of legend keys.**
The following example illustrates how the legend keys can be placed in different
locations on the plot.

    sysuse auto
    two (histogram weight if foreign==0, psty(p1bar) color(%50)) ///
        (histogram weight if foreign==1, psty(p2bar) color(%50))
    addlegend, color(%50): ///
        (bar) "Domestic", y(95) X(4690) W(-300) ///
        (bar) "Foreign",  y(95) X(1910) W(300)

Note how setting the symbol width to a negative value changes the default
placement of the key's text.

![example 3](/images/3.png)

**Headings.**
The following example illustrates how headings aligned with the symbols
or aligned with the text labels can be added.

    sysuse uslifeexp
    twoway (connect le_f le_m year)
    addlegend: ///
        . "Heading aligned with symbol" ///
        (line) () "female" ///
        - "Heading aligned with text" ///
        (line) () "male"

![example 4](/images/4.png)

**Placing the legend outside of the plot region.**
If you want to place the legend outside of the plot region, use the `margin()`
option to make sure that there is enough space for the legend in the graph's
margin.

    sysuse auto
    two (sc mpg turn, msize(large) ms(Oh)) ///
        (sc mpg turn, msize(large) ms(X) pstyle(p1)) ///
        (lfit mpg turn, pstyle(p2))
    addlegend, position(2, outside) margin(r=40): ///
        (Oh X) "Mileage (mpg)", msize(large) ///
        (line) "Fitted values"

![example 5](/images/5.png)

**Add legend to subgraph.** 
In case of a graph that contains multiple subgraphs, specify `addlegend #` to
add the legend to subgraph `#` (by default, the legend is added to all
subgraphs).

    sysuse auto
    scatter mpg trunk weight, legend(off) name(weight, replace) nodraw
    scatter mpg trunk price, legend(off) name(price, replace) nodraw
    graph combine weight price
    addlegend 2, position(2) h(4) tw(35) frame: ///
        () "Mileage per gallon" ///
        () "Trunk space"

![example 6](/images/6.png)

---

Main changes:

    09aug2026 (version 2.0.5)
    - column delimiter "&" added
    - row delimiter "\" added
    - option colskip() added

    06aug2026 (version 2.0.4)
    - option position() can now be used to move the legend to a clock position
    - options dy()/DY() and dx()/DX() can now be used to apply overall offsets to
      the legend's position
    - most lowercase position and size options now support syntax *# to multiply
      the automatically assigned value by #
    - custom symbols can now be defined by providing a list of coordinates
    - option pline can now be specified to apply pstyle(p#line) instead of
      pstyle(p#) to line symbols instad of
    - addlegend crashed if a comma was specified at the end of a key
      without specifying any options; this is fixed
    - addlegend crashed if -set dp comma- was on; this is fixed

    27jun2026 (version 2.0.3)
    - key delimiter || is now optional
    - can now type . to create a heading aligned with symbol
    - vertical variants of line, spike, rline, cap, and capsym added
    - option lstyle(p#other) is now applied to spike, cap, and capsym by default
    - y()/Y() and x()/X() specified at the level of a key's symbol are now
      interpreted as offsets from the key's overall position
    - x()/X() now sets the position of the midpoint of a key's symbol instead of the
      position of the left edge; default is now x(5) instead of x(2); default for
      tx() is now 0.75 times the symbol width
    - due to a typo, the default value for y() was set to 96 instead of 95; this is
      fixed
    - calculation of the size and position of the legend's frame no longer takes
      account of positioning and size options specified at the level of symbols 
    - format %10.0g is now used for the coordinates in the scatteri commands instead
      of full precision

    20jun2026 (version 2.0.2)
    - a key's symbol can now include text

    20jun2026 (version 2.0.1)
    - if applied to a by() graph, addlegend did not remove the global legend; this
      is fixed
    - now returning r(graphname), r(subgraphs), r(graphfamily)
    - caller version is now passed trough to addplot

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