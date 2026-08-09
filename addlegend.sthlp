{smcl}
{* 09aug2026}{...}
{vieweralsosee "[G-2] graph twoway" "help graph twoway"}{...}
{vieweralsosee "[SSC] addplot" "help addplot"}{...}
{viewerjumpto "Syntax" "addlegend##syntax"}{...}
{viewerjumpto "Description" "addlegend##description"}{...}
{viewerjumpto "Options" "addlegend##options"}{...}
{viewerjumpto "Remarks" "addlegend##remarks"}{...}
{viewerjumpto "Examples" "addlegend##examples"}{...}
{viewerjumpto "Stored results" "addlegend##results"}{...}
{viewerjumpto "References" "addlegend##references"}{...}
{viewerjumpto "Author" "addlegend##author"}{...}

{hi:help addlegend}{...}
{right:{browse "https://github.com/benjann/addlegend/"}}
{hline}

{title:Title}

{pstd}{hi:addlegend} {hline 2} Utility to add a custom legend to a twoway graph


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
    {cmd:addlegend} [{it:graphname}] [{it:{help numlist}}]
    [{cmd:,} {it:{help addlegend##opts:options}} ]
    {cmd::} {it:keylist}

{p 8 15 2}
    {cmd:_mklegend} [{it:graphname}] [{it:{help numlist}}]
    [{cmd:,} {it:{help addlegend##opts:options}} ]
    {cmd::} {it:keylist}

{pstd}
    where {it:keylist} is

{p 8 15 2}
        {it:key} [[{it:del}] {it:key} [{it:...}]]

{marker del}{...}
{pstd}
    and {it:del} is

{p2colset 9 13 13 2}{...}
{p2col : {cmd:&}}start new legend column
    {p_end}
{p2col : {cmd:\}}start new legend row
    {p_end}
{p2col : {cmd:||}}start new key within column (optional; same as omitting {it:del})
    {p_end}

{pstd}
    and the syntax of {it:key} is

{p 8 15 2}
    {it:symboldef}
    {cmd:"}{it:text}{cmd:"} [{cmd:"}{it:text}{cmd:"} [...]]
    [{cmd:,} {it:{help addlegend##sopts:symopts}}
    {it:{help addlegend##topts:txtopts}} ]

{pstd}
    where {it:symboldef} is

{p2colset 9 13 13 2}{...}
{p2col : {cmd:.}}create heading aligned with symbols
    {p_end}
{p2col : {cmd:-}}create heading aligned with text labels
    {p_end}

{pstd}
    or

{p 8 15 2}
    {cmd:(}{it:symlist} [{cmd:,} {it:{help addlegend##sopts:symopts}}]{cmd:)}
    [{cmd:(}{it:symlist} [{cmd:,} {it:{help addlegend##sopts:symopts}}]{cmd:)} [...]]

{pstd}
    where {it:symlist} is

{p 8 15 2}
    [{it:symbol} [{it:symbol} [...]]]

{pstd}
    and {it:symbol} is

{p2colset 9 22 22 2}{...}
{p2col : {it:{help symbolstyle}}}marker; may type {cmd:.} (missing) for default marker
    {p_end}
{p2col : {cmd:"}{help graph_text:{it:text}}{cmd:"}}any text
    {p_end}
{p2col : [{cmd:v}]{opt line}}vertical or horizontal line
    {p_end}
{p2col : [{cmd:v}]{opt spike}}vertical or horizontal spike
    {p_end}
{p2col : [{cmd:v}]{opt rline}}vertical or horizontal double line
    {p_end}
{p2col : {opt area}}area
    {p_end}
{p2col : {opt bar}}bar
    {p_end}
{p2col : [{cmd:v}]{opt cap}}vertical or horizontal capped spike
    {p_end}
{p2col : [{cmd:v}]{opt capsym}}vertical or horizontal spike capped with symbols
    {p_end}
{p2col : {cmd:(}{help addlegend##customsymbol:{it:numlist}}{cmd:)}}custom symbol definition
    {p_end}


{synoptset 23 tabbed}{...}
{marker opts}{synopthdr:options}
{synoptline}
{syntab :{it:{help addlegend##options:Main}}}
{synopt :{opt lskip(#)}}adjust baseline skip between legend keys
    {p_end}
{synopt :{opt col:skip(#)}}adjust horizontal skip between legend columns
    {p_end}
{synopt :{cmdab:fr:ame}[{cmd:(}{it:{help addlegend##frame:subopts}}{cmd:)}]}draw
    frame around legend
    {p_end}
{synopt :{cmdab:pos:ition(}{help addlegend##posopt:{it:spec}}{cmd:)}}move legend to specified clock position
    {p_end}
{synopt :{opt dy(#)} or {opt DY(#)}}add overall vertical offset, in percent or units of Y-axis
    {p_end}
{synopt :{opt dx(#)} or {opt DX(#)}}add overall horizontal offset, in percent or units of X-axis
    {p_end}
{synopt :{opth m:argin(marginstyle)}}reset margin of graph region
    {p_end}
{synopt :{opt pline}}set {cmd:pstyle()} to {cmd:p}{it:#}{cmd:line} instead of {cmd:p}{it:#} for line symbols
    {p_end}
{synopt :{opt nodraw}}do not update graph window
    {p_end}

{marker sopts}{...}
{syntab :{it:{help addlegend##symopts:symopts}}}
{synopt :{opt y(#)} or {opt Y(#)}}vertical position of legend key, in percent or units of Y-axis
    {p_end}
{synopt :{opt x(#)} or {opt X(#)}}horizontal position of legend key, in percent or units of X-axis
    {p_end}
{synopt :{opt h(#)} or {opt H(#)}}height of key's symbol, in percent or units of Y-axis
    {p_end}
{synopt :{opt w(#)} or {opt W(#)}}width of key's symbol, in percent or units of X-axis
    {p_end}
{synopt :{it:{help marker_options}}}options affecting look of markers
    {p_end}
{synopt :{it:{help marker_label_options}}}options affecting look of text symbols
    {p_end}
{synopt :{it:{help line_options}}}options affecting look of lines or spikes
    {p_end}
{synopt :{it:{help area_options}}}options affecting look of areas or bars
    {p_end}

{marker topts}{...}
{syntab :{it:{help addlegend##txtopts:txtopts}}}
{synopt :{opt ty(#)} or {opt TY(#)}}vertical offset of text label, in percent or units of Y-axis
    {p_end}
{synopt :{opt tx(#)} or {opt TX(#)}}horizontal offset of text label, in percent or units of X-axis
    {p_end}
{synopt :{opt tw(#)} or {opt TW(#)}}width of text label, in percent or units of X-axis
    {p_end}
{synopt :{opth t:ext(textbox_options)}}options affecting look of text label
    {p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
    {cmd:addlegend} creates a custom legend and adds it to an existing
    {helpb twoway} graph, thereby removing the legend created by Stata's
    {helpb legend_option:legend()} option. In contrast to the
    {helpb legend_option:legend()} option, {cmd:addlegend} can combine multiple
    symbols in a single legend key and the keys can be freely positioned on the
    plot. Furthermore, {cmd:addlegend} can be applied repeatedly to add
    multiple legends to the same graph.

{pstd}
    Argument {it:graphname} selects the memory graph to be affected. The default
    is to use the current (topmost) graph. Argument {it:{help numlist}}
    selects the subgraph(s) to be affected if the graph has been created using
    {helpb graph combine} or the {help by_option:{bf:by()}} option. The default
    is to modify all {helpb twoway} subgraphs found in the graph.

{pstd}
    Command {cmd:_mklegend} is the engine behind {cmd:addlegend}. It analyses
    the selected graph, creates the code for the custom legend (a set of
    {helpb twoway scatteri} commands), and stores it in macro
    {cmd:r(legend)}. {cmd:addlegend} then applies {helpb addplot} to add the
    contents of {cmd:r(legend)} to the definition of the selected graph.

{pstd}
    {cmd:addlegend} requires {helpb addplot} to be installed on the system
    ({browse "https://doi.org/10.1177/1536867X1501500308":Jann 2015}). To
    install {cmd:addplot}, type

        {com}. ssc install addplot, replace{txt}


{marker options}{...}
{title:Options}

{dlgtab:Main}

{marker lskip}{...}
{phang}
    {opt lskip(#)} sets the baseline skip between legend keys as a factor of
    the symbol height; the default is {cmd:lskip(1.5)}. Option {cmd:lskip()} has no
    effect on legend keys that are positioned explicitly by the
    {helpb addlegend##y:y()} option.

{marker colskip}{...}
{phang}
    {opt colskip(#)} sets the horizontal skip between legend columns as a
    factor of the column width (the width of the space allocated for the legend
    keys); the default is {cmd:colskip(1)}. Option {cmd:colskip()} has no
    effect on legend keys that are positioned explicitly by the
    {helpb addlegend##x:x()} option.

{marker frame}{...}
{phang}
    {cmd:frame}[{cmd:(}{it:subopts}{cmd:)}] draws a frame around the legend.
    The size and position of the frame will be determined automatically, but
    you may need to adjust its width using suboption {cmd:w()} or by setting
    the text width using option {helpb addlegend##tw:tw()}. Furthermore,
    you may want to adjust the padding (inner margin of the frame) using
    suboptions {cmd:ym()} and {cmd:xm()}. {it:subopts} are as follows.

{phang2}
    {opt ym(#)} and {opt YM(#)} set the vertical padding (margin at top
    and bottom between legend keys and frame) that is applied unless the frame
    is positioned manually using {cmd:y()} and {cmd:h()}. The default is
    {cmd:ym(2.5)}. You can also specify {opt ym(*#)} to use the default value
    multiplied by {it:#}. {cmd:YM()} takes precedence over {cmd:ym()}.

{phang2}
    {opt xm(#)} and {opt XM(#)} set the default horizontal padding (margin at
    left and right between legend keys and frame) that is applied unless the
    frame is positioned manually using {cmd:x()} and {cmd:w()}. The default is
    {cmd:xm(2)}. You can also specify {opt xm(*#)} to use the default value
    multiplied by {it:#}. {cmd:XM()} takes precedence over {cmd:xm()}.

{phang2}
    {opt y(#)} and {opt Y(#)} set the position of the top edge of the frame, in
    percent of the range of the Y-axis or in units of the Y-axis,
    respectively. You can also specify {opt y(*#)} to use the value determined
    automatically multiplied by {it:#}. {cmd:Y()} takes precedence over
    {cmd:y()}. Together, {cmd:y()} and {cmd:x()} determine the position of the
    upper-left corner of the frame.

{phang2}
    {opt x(#)} and {opt X(#)} set the position of the left edge of the frame,
    in percent of the range of the X-axis or in units of the X-axis,
    respectively. You can also specify {opt x(*#)} to use the value determined
    automatically multiplied by {it:#}. {cmd:X()} takes precedence over
    {cmd:x()}.

{phang2}
    {opt h(#)} and {opt H(#)} set the height of the frame, in percent of the
    range of the Y-axis or in units of the Y-axis, respectively. You can
    also specify {opt h(*#)} to use the value determined automatically
    multiplied by {it:#}. {cmd:H()} takes precedence over {cmd:h()}.

{phang2}
    {opt w(#)} and {opt W(#)} set the width of the frame, in percent of the
    range of the X-axis or in units of the X-axis, respectively. You can
    also specify {opt w(*#)} to use the value determined automatically
    multiplied by {it:#}. {cmd:W()} takes precedence over {cmd:w()}.

{phang2}
    {it:area_options} are options affecting the look of the fill and outline
    of the frame; see help {it:{help area_options}}. By default, options
    {cmd:lstyle(foreground)} and {cmd:fcolor(white)} will be applied. For
    example, type {cmd:fcolor(none)} for a frame without fill, or type
    {cmd:lcolor(%0)} for a filled frame without outline.

{marker posopt}{...}
{phang}
    {cmd:position(}{it:{help clockposstyle}}[{cmd:,} {opt out:side}]{cmd:)}
    moves the legend to the specified clock position in the plot region, or if
    suboption {cmd:outside} is specified, in the graph's margin (use option
    option {helpb addlegend##margin:margin()} to adjust the graph's margin if
    needed). Use options {cmd:dy()} and {cmd:dx()} to fine-tune the legend's
    placement when applying {cmd:position()}.

{marker dy}{...}
{phang}
    {opt dy(#)} and {opt DY(#)} apply a vertical offset to
    the position of the legend, in percent of the range of the Y-axis or in
    units of the Y-axis, respectively. The default is {cmd:dy(0)}. {cmd:DY()}
    takes precedence over {cmd:dy()}.

{marker dx}{...}
{phang}
    {opt dx(#)} and {opt DX(#)} apply a horizontal offset to
    the position of the legend, in percent of the range of the X-axis or in
    units of the X-axis, respectively. The default is {cmd:dx(0)}. {cmd:DX()}
    takes precedence over {cmd:dx()}.

{marker margin}{...}
{phang}
    {opt margin(marginstyle)} resets the margin of the graph region; see help
    {it:{help marginstyle}}. This is useful if you want to place the legend in
    the graph's margin instead of the plot region. {cmd:margin()} has
    no effect if specified with {cmd:_mklegend}.

{marker pline}{...}
{phang}
    {opt pline} sets {cmd:pstyle()} to {cmd:p}{it:#}{cmd:line} instead of
    {cmd:p}{it:#} for symbols created by {cmd:line}, {cmd:vline},
    {cmd:rline}, and {cmd:vrline}.

{phang}
    {opt nodraw} causes the graph data to be modified without updating the
    display in the graph window. Use {helpb graph display}
    to view the modified graph after applying {cmd:addlegend} with option
    {cmd:nodraw}. {cmd:nodraw} has no effect if specified with {cmd:_mklegend}.

{marker symopts}{...}
{dlgtab:symopts}

{marker y}{...}
{phang}
    {opt y(#)} and {opt Y(#)} set the vertical position of the (first) legend
    key (i.e., the midpoint of the vertical space allocated for the key's
    symbol), in percent of the range of the Y-axis or in units of the Y-axis,
    respectively. The default is {cmd:y(95)}. You can also specify {opt y(*#)}
    to use the value determined automatically multiplied by {it:#}. {cmd:Y()}
    takes precedence over {cmd:y()}.

{pmore}
    Specifying {cmd:y()} or {cmd:Y()} only sets the position of the current
    (first) key. The positions of subsequent keys in the same legend column are
    determined as {it:y} - {it:lskip} * {it:h}, where {it:y} and {it:h} are the
    position and symbol height of the previous key and {it:lskip} is the
    baselineskip as set by option {helpb addlegend##lskip:lskip()}. Column
    delimiter {helpb addlegend##del:&} resets the value to the position of the
    first key in current legend row.

{pmore}
    If specified at the level of a key's symbol, {cmd:y()} and {cmd:Y()} have
    an alternative meaning: they are interpreted as the vertical offset of the
    symbol from the key's overall position, in percent of the range of the
    Y-axis or in units of the Y-axis, respectively. The default vertical offset
    is {cmd:0}. You can also specify {opt y(*#)} to set the offset to {it:#}
    times the symbol height (as set at the level of the key).

{marker x}{...}
{phang}
    {opt x(#)} and {opt X(#)} set the horizontal position of the legend key
    (i.e., the midpoint of the horizontal space allocated for the key's
    symbol), in percent of the range of the X-axis or in units of the X-axis,
    respectively. The default is {cmd:x(5)}. You can also specify {opt x(*#)}
    to use the value determined automatically multiplied by {it:#}. {cmd:X()}
    takes precedence over {cmd:y()}.

{pmore}
    Column delimiter {helpb addlegend##del:&} resets the default value to
    {it:x} + {it:colskip} * {it:width}, where {it:x} is the position of the
    previous key, {it:colskip} is as set by option
    {helpb addlegend##colskip:colskip()}, and {it:width} is the total width
    allocated for the previous key, including symbol and text label, plus half
    the symbol width. Row delimiter {helpb addlegend##del:\} resets the default
    value to the horizontal position of the very first key.

{pmore}
    If specified at the level of a key's symbol, {cmd:x()} and {cmd:X()} have
    an alternative meaning: they are interpreted as the horizontal offset of
    the symbol from the key's overall position, in percent of the range of the
    X-axis or in units of the X-axis, respectively. The default horizontal
    offset is {cmd:0}. You can also specify {opt x(*#)} to set the offset to
    {it:#} times the symbol width (as set at the level of the key).

{marker h}{...}
{phang}
    {opt h(#)} and {opt H(#)} set the height to be allocated for the legend
    key's symbol, in percent of the range of the Y-axis or in units of the
    Y-axis, respectively. The default is {cmd:h(5)}. You can also specify
    {opt h(*#)} to use the value determined automatically multiplied by
    {it:#}. {cmd:H()} takes precedence over {cmd:h()}.

{marker w}{...}
{phang}
    {opt w(#)} and {opt W(#)} set the width to be allocated for the legend
    key's symbol, in percent of the range of the X-axis or in units of the
    X-axis, respectively. The default is {cmd:w(5)}. You can also specify
    {opt w(*#)} to use the value determined automatically multiplied by
    {it:#}. {cmd:W()} takes precedence over {cmd:w()}.

{phang}
    {it:marker_options} are options affecting the look of the markers included
    in the legend key's symbol; see help {it:{help marker_options}}.

{pmore}
    If omitted, option {cmd:pstyle()} will be set automatically based on the
    order of the keys. To be precise, {cmd:pstyle()} will be set to
    {cmd:p}{it:#} (or {cmd:p}{it:#}{cmd:area} for symbol {cmd:area} or
    {cmd:p}{it:#}{cmd:bar} for symbol {cmd:bar}), where {it:#} is the position of
    the key (not counting headings; staring over at 1 after 15). For line symbols,
    the default is to use {cmd:p}{it:#}; specify option
    {helpb addlegend##pline:pline} to use {cmd:p}{it:#}{cmd:line}.

{phang}
    {it:marker_label_options} are options affecting the look of text included
    in the legend key's symbol; see help {it:{help marker_label_options}}. If omitted,
    option {cmd:mlabposition()} will be set to {cmd:0}.

{phang}
    {it:line_options} are options affecting the look of the lines or spikes
    included in the legend key's symbol; see help {it:{help line_options}}. If omitted,
    option {cmd:lstyle()} will be set to {cmd:p}{it:#}{cmd:other} in case of
    {cmd:spike}, {cmd:cap}, and {cmd:capsym}, where {it:#} is the number
    of the plot as set by {cmd:pstyle()}.

{phang}
    {it:area_options} are options affecting the look of the areas or bars included
    in the legend key's symbol; see help {it:{help area_options}}.

{marker txtopts}{...}
{dlgtab:txtopts}

{marker ty}{...}
{phang}
    {opt ty(#)} and {opt TY(#)} set the vertical offset of the text label from
    the key's position as set by {cmd:y()} or {cmd:Y()}, in percent of the
    range of the Y-axis or in units of the Y-axis, respectively. The default is
    {cmd:ty(0)}. You can also specify {opt ty(*#)} to use the value determined
    automatically multiplied by {it:#}. {cmd:TY()} takes precedence over
    {cmd:ty()}.

{marker tx}{...}
{phang}
    {opt tx(#)} and {opt TX(#)} set the horizontal offset of the text label
    from the key's position as set by {cmd:x()} or {cmd:X()}, in percent of the
    range of the X-axis or in units of the X-axis, respectively. The default is
    to set the offset to 0.75 times the width of the space allocated for the
    key's symbol. You can also specify {opt tx(*#)} to use the value determined
    automatically multiplied by {it:#}. {cmd:TX()} takes precedence over
    {cmd:tx()}.

{marker tw}{...}
{phang}
    {opt tw(#)} and {opt TW(#)} set the width of the space allocated for the
    text label, in percent of the range of the Y-axis or in units of the
    Y-axis, respectively. The default is {cmd:tw(20)}. You can also specify
    {opt tw(*#)} to use the value determined automatically multiplied by
    {it:#}. {cmd:TW()} takes precedence over {cmd:tw()}.

{pmore}
    Option {cmd:tw()} has no effect on how the text is displayed, but it is
    relevant for determining the width of the space allocated for the legend
    key, which affects the behavior of
    {helpb addlegend##frame:frame()},
    {helpb addlegend##posopt:position()}, and
    {helpb addlegend##colskip:colskip()}.

{phang}
    {opt text(textbox_options)} specifies options affecting the look of the
    text label, such as its size, color, or justification; see help
    {it:{help textbox_options}}. If omitted, options {cmd:placement()} and
    {cmd:justification()} are set automatically depending on the sign of
    {cmd:tx()}.


{marker remarks}{...}
{title:Remarks}

    {help addlegend##pos:How to use the position and size options}
    {help addlegend##customsymbol:Defining a custom symbol}

{marker pos}{...}
{dlgtab:How to use the position and size options}

{pstd}
    {cmd:addlegend} determines the position and size of the legend based on the
    dimensions of the axes of the selected graph (or the first selected
    subgraph). Use option {helpb addlegend##posopt:position()} to move the
    legend to a specified clock position on the graph, and possibly fine-tune
    the position using options {helpb addlegend##dy:dy()} and
    {helpb addlegend##dx:dx()}. In many cases, you will also need to specify
    option {helpb addlegend##tw:tw()} at the global level to set the width of
    the space allocated for text labels (since {cmd:addlegend} uses a fixed
    default that does not respond to the content of the labels). Depending on
    the plot's aspect ratio, you may also want to specify options
    {helpb addlegend##h:h()} and {helpb addlegend##w:w()} at the global level
    to set the height and width of the space allocated for the keys' symbols
    (which also affects the baseline skip between keys). Furthermore, use the
    column ({helpb addlegend##del:&}) and row ({helpb addlegend##del:\})
    delimiters to arrange the keys within the legend (unless you are happy with
    a single-column legend).

{pstd}
    For more advanced applications, you can specify options
    {helpb addlegend##y:y()},
    {helpb addlegend##x:x()},
    {helpb addlegend##h:h()},
    {helpb addlegend##w:w()},
    {helpb addlegend##ty:ty()},
    {helpb addlegend##tx:tx()}, and
    {helpb addlegend##tw:tw()} at the level of individual keys. This
    overrides the settings for these keys and also affects the default behavior
    for subsequent keys. Additionally, options
    {helpb addlegend##y:y()},
    {helpb addlegend##x:x()},
    {helpb addlegend##h:h()}, and
    {helpb addlegend##w:w()} can be specified at the symbol level to override
    the settings for individual symbols (without affecting subsequent symbols).

{pstd}
    Note that most of the above options come in two flavors, lower case and
    upper case. Use the lowercase variant, e.g. {cmd:dy()}, to specify a setting
    in percent of the range of the relevant axis; use the uppercase variant,
    e.g. {cmd:DY()}, to specify a setting in original units of the axis. If both
    are specified, the uppercase variant takes precedence over the lowercase
    variant.

{marker customsymbol}{...}
{dlgtab:Defining a custom symbol}

{pstd}
    Use syntax

        {cmd:(}{it:y}1 {it:x}1 [{it:y}2 {it:x}2 ...]{cmd:)}

{pstd}
    to define a custom symbol within a legend key, where {it:y}1 and {it:x}1
    etc. specify the (normalized) coordinates for drawing the symbol.

{pstd}
    The coordinates are interpreted as offsets around the center of the space
    allocated for the symbol, in units corresponding to half the height or half
    the width of the space, respectively. For example, typing {cmd:(-1 -1 1 1)}
    would draw a diagonal line from the lower left corner to the upper right
    corner of the allocated space. Note that missing values can be used to
    create symbols that have multiple parts. For example, typing
    {cmd:(-1 -1 1 1 . . 1 -1 -1 1)} would draw two diagonal lines forming a cross.

{pstd}
    By default, the symbol is drawn as an outline. Apply option {cmd:recast(area)}
    to draw the symbol as an area. That is, specifying a legend key as

        {cmd:((}{it:y}1 {it:x}1 ...{cmd:))} {cmd:"}{it:text}{cmd:"}

{pstd}
    will draw the symbol as outline, whereas specifying

        {cmd:((}{it:y}1 {it:x}1 ...{cmd:), recast(area))} {cmd:"}{it:text}{cmd:"}

{pstd}
    will draw the symbol as area.


{marker examples}{...}
{title:Examples}

{dlgtab:Composite symbols}

{pstd}
    The following example illustrates how to create a composite symbol.

        . {stata sysuse auto}
{p 8 12 2}
    . {stata twoway (sc mpg turn, msize(large) ms(Oh)) (sc mpg turn, msize(large) ms(X) pstyle(p1)) (lfit mpg turn, pstyle(p2))}
    {p_end}
{p 8 12 2}
    . {stata `"addlegend, position(2) frame: (Oh X, msize(large)) "Mileage (mpg)" || (line) "Fitted values""'}
    {p_end}

{pstd}
    Option {cmd:position(2)} has been specified to place the legend in the
    top-right corner of the plot region. Note that key delimiter {cmd:||} is
    optional; the above command could also be typed as follows:

{p 8 12 2}
    . {stata `"addlegend, position(2) frame: (Oh X, msize(large)) "Mileage (mpg)" (line) "Fitted values""'}
    {p_end}

{dlgtab:Custom positioning of legend keys}

{pstd}
    The following example illustrates how the individual legend keys can be
    placed in custom locations on the plot.

        . {stata sysuse auto}
{p 8 12 2}
    . {stata twoway (hist weight if foreign==0, psty(p1bar) color(%50)) (hist weight if foreign==1, psty(p2bar) color(%50))}
    {p_end}
{p 8 12 2}
    . {stata `"addlegend, color(%50): (bar) "Domestic", y(95) X(4690) W(-300) || (bar) "Foreign", y(95) X(1910) W(300)"'}
    {p_end}

{pstd}
    Note how setting the symbol width to a negative value changes the default
    placement of the key's text label.

{dlgtab:Headings}

{pstd}
    To create a heading that is aligned with the key symbols, type

        {cmd:.} {cmd:"}{it:text}{cmd:"} [{cmd:"}{it:text}{cmd:"} [...]]

{pstd}
    Alternatively, to create a heading that is aligned with the
    text labels, type

        {cmd:-} {cmd:"}{it:text}{cmd:"} [{cmd:"}{it:text}{cmd:"} [...]]

{pstd}
    The following example illustrates the difference.

        . {stata sysuse uslifeexp}
{p 8 12 2}
    . {stata twoway (connect le_f le_m year)}
    {p_end}
{p 8 12 2}
    . {stata `"addlegend: . "Heading aligned with symbol" || (line) () "female" || - "Heading aligned with text" || (line) () "male""'}
    {p_end}

{dlgtab:Placing the legend outside of the plot region}

{pstd}
    If you want to place the legend outside of the plot region, use the
    {helpb addlegend##margin:margin()} option to make sure that there is enough
    space for the legend in the graph's margin.

        . {stata sysuse auto}
{p 8 12 2}
    . {stata twoway (sc mpg turn, msize(large) ms(Oh)) (sc mpg turn, msize(large) ms(X) pstyle(p1)) (lfit mpg turn, pstyle(p2))}
    {p_end}
{p 8 12 2}
    . {stata `"addlegend, position(2, outside) margin(r=40): (Oh X, msize(large)) "Mileage (mpg)" || (line) "Fitted values""'}
    {p_end}

{dlgtab:Add legend to subgraph}

{pstd}
    In case of a graph that contains multiple subgraphs, specify
    {cmd:addlegend} {it:#} to add the legend to subgraph {it:#} (by default,
    the legend is added to all subgraphs).

        . {stata sysuse auto}
{p 8 12 2}
    . {stata scatter mpg trunk weight, legend(off) name(weight, replace) nodraw}
    {p_end}
{p 8 12 2}
    . {stata scatter mpg trunk price, legend(off) name(price, replace) nodraw}
    {p_end}
{p 8 12 2}
    . {stata graph combine weight price}
    {p_end}
{p 8 12 2}
    . {stata `"addlegend 2, position(2) h(4) tw(35) frame: () "Mileage per gallon" || () "Trunk space""'}
    {p_end}

{pstd}
    Note that specifying a key's symbol as {cmd:()} selects the plot's default
    marker symbol.

{dlgtab:Use of _mklegend}

{pstd}
    {cmd:addlegend} is implemented as a wrapper for {cmd:_mklegend} followed by
    {helpb addplot}. In some cases you might want to apply {cmd:_mklegend}
    manually instad of using {cmd:addlegend}. Note that {cmd:_mklegend} stores
    the legend's code in macro {cmd:r(legend)}.

{pstd}
    For example, here is how you could create a graph that includes both, a
    legend created by Stata's {cmd:legend()} option and a legend created by
    {cmd:_mklegend}:

        . {stata sysuse auto}
{p 8 12 2}
    . {stata twoway (sc mpg turn) (lfit mpg turn)}
    {p_end}
{p 8 12 2}
    . {stata `"_mklegend, position(2) frame: () "Observations" || (line) "Linear fit""'}
    {p_end}
{p 8 12 2}
    . {stata `"addplot: `r(legend)', norescaling legend(order(1 "Mileage (mpg)" 2 "Fitted values"))"'}
    {p_end}

{pstd}
    Furthermore, rather than using {helpb addplot} you could include the
    code generated by {cmd:_mklegend} directly in a {helpb twoway} command:

        . {stata sysuse auto}
{p 8 12 2}
    . {stata twoway (sc mpg turn) (lfit mpg turn), nodraw}
    {p_end}
{p 8 12 2}
    . {stata `"_mklegend, position(2) frame: () "Observations" || (line) "Linear fit""'}
    {p_end}
{p 8 12 2}
    . {stata twoway (sc mpg turn) (lfit mpg turn) `r(legend)', legend(off)}
    {p_end}

{pstd}
    Likewise, you could include the legend's code in an {helpb addplot_option:addplot()}
    option:

        . {stata sysuse auto}
{p 8 12 2}
    . {stata lpoly weight length, degree(1) ci nodraw}
    {p_end}
{p 8 12 2}
    . {stata `"_mklegend, tw(25) frame: () "data" || (area, astyle(ci)) (line) "lopoly fit and 95% CI""'}
    {p_end}
{p 8 12 2}
    . {stata lpoly weight length, degree(1) ci legend(off) addplot(`r(legend)')}
    {p_end}


{marker results}{...}
{title:Stored results}

{pstd} Scalars:

{p2colset 5 21 21 2}{...}
{p2col : {cmd:r(Ymin)}}minimum of the graph's Y axis{p_end}
{p2col : {cmd:r(Ymax)}}maximum of the graph's Y axis{p_end}
{p2col : {cmd:r(Xmin)}}minimum of the graph's X axis{p_end}
{p2col : {cmd:r(Xmax)}}maximum of the graph's X axis{p_end}
{p2col : {cmd:r(lskip)}}value of {cmd:lskip()}{p_end}
{p2col : {cmd:r(dy)}}value of {cmd:dy()}{p_end}
{p2col : {cmd:r(dx)}}value of {cmd:dx()}{p_end}
{p2col : {cmd:r(DY)}}value of {cmd:DY()}{p_end}
{p2col : {cmd:r(DX)}}value of {cmd:DX()}{p_end}
{p2col : {cmd:r(y)}}(initial) value of {cmd:y()}{p_end}
{p2col : {cmd:r(x)}}(initial) value of {cmd:x()}{p_end}
{p2col : {cmd:r(h)}}(initial) value of {cmd:h()}{p_end}
{p2col : {cmd:r(w)}}(initial) value of {cmd:w()}{p_end}
{p2col : {cmd:r(ty)}}(initial) value of {cmd:ty()}{p_end}
{p2col : {cmd:r(tx)}}(initial) value of {cmd:tx()}{p_end}
{p2col : {cmd:r(tw)}}(initial) value of {cmd:tw()}{p_end}
{p2col : {cmd:r(Y)}}(initial) value of {cmd:Y()}{p_end}
{p2col : {cmd:r(X)}}(initial) value of {cmd:X()}{p_end}
{p2col : {cmd:r(H)}}(initial) value of {cmd:H()}{p_end}
{p2col : {cmd:r(W)}}(initial) value of {cmd:W()}{p_end}
{p2col : {cmd:r(TY)}}(initial) value of {cmd:TY()}{p_end}
{p2col : {cmd:r(TX)}}(initial) value of {cmd:TX()}{p_end}
{p2col : {cmd:r(TW)}}(initial) value of {cmd:TW()}{p_end}
{p2col : {cmd:r(fr_y)}}value of {cmd:frame(y())}{p_end}
{p2col : {cmd:r(fr_x)}}value of {cmd:frame(x())}{p_end}
{p2col : {cmd:r(fr_h)}}value of {cmd:frame(h())}{p_end}
{p2col : {cmd:r(fr_w)}}value of {cmd:frame(w())}{p_end}
{p2col : {cmd:r(fr_ym)}}value of {cmd:frame(ym())}{p_end}
{p2col : {cmd:r(fr_xm)}}value of {cmd:frame(xm())}{p_end}
{p2col : {cmd:r(fr_Y)}}value of {cmd:frame(Y())}{p_end}
{p2col : {cmd:r(fr_X)}}value of {cmd:frame(X())}{p_end}
{p2col : {cmd:r(fr_H)}}value of {cmd:frame(H())}{p_end}
{p2col : {cmd:r(fr_W)}}value of {cmd:frame(W())}{p_end}
{p2col : {cmd:r(fr_YM)}}value of {cmd:frame(YM())}{p_end}
{p2col : {cmd:r(fr_XM)}}value of {cmd:frame(XM())}{p_end}

{pstd} Macros:

{p2col : {cmd:r(legend)}}code that generates the legend
    {p_end}
{p2col : {cmd:r(graphname)}}name of graph
    {p_end}
{p2col : {cmd:r(subgraphs)}}indices of selected subgraphs
    {p_end}
{p2col : {cmd:r(graphfamily)}}{cmd:twoway}, {cmd:by}, or {cmd:combine}
    {p_end}


{marker references}{...}
{title:References}

{phang}
    Jann, B. 2015. A note on adding objects to an existing twoway graph. The Stata Journal
    15(3): 751-755. {browse "https://doi.org/10.1177/1536867X1501500308"}
    {p_end}


{marker author}{...}
{title:Author}

{pstd}
    Ben Jann, University of Bern, ben.jann@unibe.ch

{pstd}
    Thanks for citing this software as follows:

{pmore}
    Jann, B. 2026. addlegend: Stata module to add a custom legend to a twoway graph. Available from
    {browse "https://ideas.repec.org/c/boc/bocode/s459754.html"}.

