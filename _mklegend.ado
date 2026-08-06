*! version 2.0.4  06aug2026  Ben Jann

program _mklegend
    version 14
    _on_colon_parse `0'
    local 0 `"`s(before)'"'
    local keys `"`s(after)'"'
    _parse comma args 0 : 0
    syntax [, POSition(str) * ]
    if `"`position'"'!="" parse_position `position'
    __mklegend `args', `options': `keys'
    // apply second run if position() has been specified
    if `"`position'"'=="" exit
    mata: extract_opts(("DY", "DX"))
    if r(fr_Y)<. {
        local minY = min(`minY', r(fr_Y), r(fr_Y) - r(fr_H))
        local maxY = max(`maxY', r(fr_Y), r(fr_Y) - r(fr_H))
        local minX = min(`minX', r(fr_X), r(fr_X) + r(fr_W))
        local maxX = max(`maxX', r(fr_X), r(fr_X) + r(fr_W))
    }
    if r(Ymax)<r(Ymin) {
        local tmp `minY'
        local minY `maxY'
        local maxY `tmp'
    }
    if r(Xmax)<r(Xmin) {
        local tmp `minX'
        local minX `maxX'
        local maxX `tmp'
    }
    if inlist(`position',0,3,9) {
        local DY = (r(Ymin) + r(Ymax))/2 - (`minY' + `maxY')/2
    }
    else if inlist(`position',1,2,10,11,12) {
        local inside = `"`outside'"'=="" | inlist(`position',2,10)
        if `inside' local DY = r(Ymax) - `maxY'
        else        local DY = r(Ymax) - `minY' + (r(Ymax)-r(Ymin))/20
    }
    else if inlist(`position',4,5,6,7,8) {
        local inside = `"`outside'"'=="" | inlist(`position',4,8)
        if `inside' local DY = r(Ymin) - `minY'
        else        local DY = r(Ymin) - `maxY' - (r(Ymax)-r(Ymin))/20
    }
    if inlist(`position',0,6,12) {
        local DX = (r(Xmin) + r(Xmax))/2 - (`minX' + `maxX')/2
    }
    else if inlist(`position',1,2,3,4,5) {
        local inside = `"`outside'"'=="" | inlist(`position',1,5)
        if `inside' local DX = r(Xmax) - `maxX'
        else        local DX = r(Xmax) - `minX' + (r(Xmax)-r(Xmin))/20
    }
    else if inlist(`position',7,8,9,10,11) {
        local inside = `"`outside'"'=="" | inlist(`position',7,11)
        if `inside' local DX = r(Xmin) - `minX'
        else        local DX = r(Xmin) - `maxX' - (r(Xmax)-r(Xmin))/20
    }
    local DY = `DY' + r(DY)
    local DX = `DX' + r(DX)
    __mklegend `args', DY(`DY') DX(`DX') `options': `keys'
end

program parse_position
    _parse comma position 0 : 0
    syntax [, OUTside ]
    c_local outside `outside'
    numlist `"`position'"', int max(1) range(>=0 <=12)
    c_local position `r(numlist)'
end

program __mklegend, rclass
    _on_colon_parse `0'
    local 0 `"`s(before)'"'
    
    // parse s(after)
    mata: keys_expand() // returns key_n, key_#
    
    // parse [graphname] [numlist]
    _parse comma subgr 0 : 0
    gettoken graph : subgr
    capt confirm name `graph'
    if _rc==0 gettoken graph subgr : subgr
    else local graph
    if `"`subgr'"'!="" {
        numlist `"`subgr'"', integer range(>=1)
        local subgr `r(numlist)'
    }
    
    // parse options
    syntax [, nodraw Margin(passthru) pline /*
        */ FRame FRame2(str) lskip(real 1.5) dy(real 0) dx(real 0)/*
        */ y(str) x(str) h(str) w(str) ty(str) tx(str) tw(str) Text(str)/*
        */ PSTYle(passthru) * ]
    parse_num y `y' // y, _y
    if  "`y'"=="" local y 95
    if "`_y'"!="" local y = `y' * `_y'
    parse_num x `x' // x, _x
    if  "`x'"=="" local x 5
    if "`_x'"!="" local x = `x' * `_x'
    parse_num h `h' // h, _h
    if  "`h'"=="" local h 5
    if "`_h'"!="" local h = `h' * `_h'
    parse_num w `w' // w, _w
    if  "`w'"=="" local w 5 
    if "`_w'"!="" local w = `w' * `_w'
    parse_num ty `ty' // ty, _ty
    if  "`ty'"=="" local ty 0
    if "`_ty'"!="" local ty = `ty' * `_ty'
    parse_num tx `tx' // tx, _tx
    if "`tx'"==""  local tx .
    local txw 0.75
    if "`_tx'"!="" local txw = `txw' * `_tx'
    parse_num tw `tw' // tw, _tw
    if  "`tw'"=="" local tw 20
    if "`_tw'"!="" local tw = `tw' * `_tw'
    mata: extract_opts(("DY", "DX", "Y", "X", "H", "W", "TY", "TX", "TW"))
    foreach opt in DY DX Y X H W TY TX TW {
        if "``opt''"=="" local `opt' .
        else             numlist `"``opt''"', max(1)
    }
    parse_topts, `text' // returns place, just, topts
    if `"`frame'`frame2'"'!="" {
        local frame frame
        parse_frame, `frame2'
    }
    
    // get limits of plotregion from graph
    parse_graph "`graph'" "`subgr'" // => graph subgr grfam Ymin Ymax Xmin Xmax
    local Yr = (`Ymax' - `Ymin')
    local Xr = (`Xmax' - `Xmin')
    if `DY'>=. local DY = `dy' * `Yr' / 100
    else       local dy = `DY' * 100 / `Yr'
    if `DX'>=. local DX = `dx' * `Xr' / 100
    else       local dx = `DX' * 100 / `Xr'
    if `Y'>=.  local Y  = `Ymin' + `y' * `Yr' / 100
    else       local y  = (`Y' - `Ymin') * 100 / `Yr' 
    if `X'>=.  local X  = `Xmin' + `x' * `Xr' / 100
    else       local x  = (`X' - `Xmin') * 100 / `Xr' 
    if `H'>=.  local H  = `h' * `Yr' / 100
    else       local h  = `H' * 100 / `Yr'
    if `W'>=.  local W  = `w' * `Xr' / 100
    else       local w  = `W' * 100 / `Xr'
    if `TY'>=. local TY = `ty' * `Yr' / 100
    else       local ty = `TY' * 100 / `Yr'
    if `TX'>=. local TX = `tx' * `Xr' / 100
    else       local tx = `TX' * 100 / `Xr'
    if `TW'>=. local TW = `tw' * `Xr' / 100
    else       local tw = `TW' * 100 / `Xr'
    
    // global settings
    foreach opt in Xmax Xmin Ymax Ymin lskip DX DY dx dy/*
         */ TW TX TY W H X Y tw tx ty w h x y {
        return scalar `opt' = ``opt''
    }
    
    // create keys
    local minY .
    local maxY .
    local minX .
    local maxX .
    local p 0
    forv i=1/`key_n' {
        parse_key `minY' `maxY' `minX' `maxX' `p' `Ymin' `Yr' `Xmin' `Xr'/*
            */ `DY' `DX' `Y' `X' `H' `W' `"`pstyle'"' "`pline'" `"`options'"'/*
            */ `TY' `TX' `txw' `TW' `"`place'"' `"`just'"' `"`topts'"'/*
            */ `key_`i'' // returns plots, p, Y, X, H, W, TY, ...
        local legend `legend' `plots'
        local Y = `Y' - `lskip' * `H'
    }
    if `minY'>=. local minY `Y'
    if `maxY'>=. local maxY `Y'
    if `minX'>=. local minX `X'
    if `maxX'>=. local maxX `X'
    
    // create frame
    if "`frame'"!="" {
        if `fr_YM'>=. local fr_YM = `fr_ym' * `Yr' / 100
        else          local fr_xm = `fr_YM' * 100 / `Yr'
        if `fr_XM'>=. local fr_XM = `fr_xm' * `Xr' / 100
        else          local fr_xm = `fr_XM' * 100 / `Xr'
        local fr_B = cond(`Yr'<0,`maxY',`minY') - `fr_YM'
        local fr_T = cond(`Yr'<0,`minY',`maxY') + `fr_YM'
        local fr_L = cond(`Xr'<0,`maxX',`minX') - `fr_XM'
        local fr_R = cond(`Xr'<0,`minX',`maxX') + `fr_XM'
        if `fr_Y'>=. {
            if       `fr_y'<. local fr_Y = `Ymin' + `fr_y' * `Yr' / 100
            else if `fr__y'<. local fr_Y = `fr_T' * `fr__y'
            else              local fr_Y = `fr_T'
        }
        if `fr_y'>=. local fr_y = (`fr_Y' - `Ymin') / `Yr' * 100
        if `fr_H'>=. {
            if       `fr_h'<. local fr_H = `fr_y' * `Yr' / 100
            else if `fr__h'<. local fr_H = (`fr_Y' - `fr_B') * `fr__h'
            else              local fr_H =  `fr_Y' - `fr_B'
        }
        if `fr_h'>=. local fr_h = `fr_H' / `Yr' * 100
        if `fr_X'>=. {
            if       `fr_x'<. local fr_X = `Xmin' + `fr_x' * `Xr' / 100
            else if `fr__x'<. local fr_X = `fr_L' * `fr__x'
            else              local fr_X = `fr_L'
        }
        if `fr_x'>=. local fr_x = (`fr_X' - `Xmin') / `Xr' * 100
        if `fr_W'>=. {
            if       `fr_w'<. local fr_W = `fr_w' * `Xr' / 100
            else if `fr__w'<. local fr_W = (`fr_R' - `fr_X') * `fr__w'
            else              local fr_W =  `fr_R' - `fr_X'
        }
        if `fr_w'>=. local fr_w = `fr_W' / `Xr' * 100
        setdim fr_B = `fr_Y' - `fr_H' + `DY'
        setdim fr_T = `fr_Y' + `DY'
        setdim fr_L = `fr_X' + `DX'
        setdim fr_R = `fr_X' + `fr_W' + `DX'
        local legend (scatteri `fr_B' `fr_L' `fr_B' `fr_R' `fr_T' `fr_R'/*
            */ `fr_T' `fr_L', recast(area) nodropbase `fr_opts') `legend'
        foreach opt in XM YM W H X Y xm ym w h x y {
            return scalar fr_`opt' = `fr_`opt''
        }
    }
    
    // return result
    return local graphfamily `"`grfam'"'
    return local subgraphs   `"`subgr'"'
    return local graphname   `"`graph'"'
    return local legend      `"`legend'"'
    c_local minY `minY'
    c_local maxY `maxY'
    c_local minX `minX'
    c_local maxX `maxX'
end

program parse_topts
    syntax [, PLACEment(str) Justification(str) * ]
    c_local place `"`placement'"'
    c_local just `"`justification'"'
    c_local topts `options'
end

program parse_graph
    gettoken graph 0 : 0
    gettoken plots 0 : 0
    gettoken plot    : plots
    if `"`graph'"'=="" {
        local graph `"`._Gr_Global.current_graph'"'
        if `"`graph'"'=="" { // no graph available
            di as txt "(no graph found; assuming range 0 to 100 for both axes)"
            c_local graph ""
            c_local subgr ""
            c_local grfam ""
            c_local Ymin 0
            c_local Ymax 100
            c_local Xmin 0
            c_local Xmax 100
            exit
        }
    }
    // obtain defaults from graph
    capt classutil d `graph'
    if _rc {
        di as err `"graph `graph' not found"'
        exit 111
    }
    if "`plot'"!="" {
        capt classutil d `graph'.graphs[`plot']
        if _rc {
            di as err `"subgraph `plot' not found"'
            exit 111
        }
        local grtype `"`.`graph'.graphs[`plot'].graphfamily'"'
        if `"`grtype'"'!="twoway" {
            di as err `"subgraph `plot' not twoway"'
            exit 498
        }
    }
    else {
        local grtype `"`.`graph'.graphfamily'"'
        if `"`grtype'"'!="twoway" {
            local plots
            local nplots `"`.`graph'.n'"'
            capt confirm integer number `nplots'
            if _rc==0 {
                forv plot = 1/`nplots' {
                    if `"`.`graph'.graphs[`plot'].graphfamily'"'=="twoway" {
                        local plots `plots' `plot'
                    }
                }
            }
            if "`plots'"=="" {
                di as err "no twoway subgraphs found in `graph'"
                exit 111
            }
            gettoken plot : plots
        }
    }
    if "`plot'"=="" local Graph `graph'
    else            local Graph `graph'.graphs[`plot']
    foreach Z in Y X {
        local z = strlower("`Z'")
        local `z'rev `.`Graph'.plotregion1.`z'scale.reverse.istrue'
        if `"``z'rev'"'=="1" {
            c_local `Z'min `.`Graph'.plotregion1.`z'scale.curmax'
            c_local `Z'max `.`Graph'.plotregion1.`z'scale.curmin'
        }
        else {
            c_local `Z'min `.`Graph'.plotregion1.`z'scale.curmin'
            c_local `Z'max `.`Graph'.plotregion1.`z'scale.curmax'
        }
    }
    c_local graph "`graph'"
    c_local subgr "`plots'"
    c_local grfam "`.`graph'.graphfamily'"
end

program parse_frame
    syntax [, y(str) x(str) h(str) w(str) ym(str) xm(str)/*
        */ LSTYle(passthru) FColor(passthru) * ]
    parse_num y `y' // y, _y
    parse_num x `x' // x, _x
    parse_num h `h' // h, _h
    parse_num w `w' // w, _w
    parse_num ym `ym' // ym, _ym
    if "`ym'"==""  local ym 2.5
    if "`_ym'"!="" local ym = `ym' * `_ym'
    parse_num xm `xm' // xm, _xm
    if "`xm'"==""  local xm 2
    if "`_xm'"!="" local xm = `xm' * `_xm'
    mata: extract_opts(("Y", "X", "H", "W", "YM", "XM"))
    foreach opt in Y X H W YM XM {
        if "``opt''"!="" numlist `"``opt''"', max(1)
    }
    foreach opt in y _y x _x h _h w _w ym xm Y X H W YM XM {
        if "``opt''"=="" local `opt' .
        c_local fr_`opt' `"``opt''"'
    }
    if `"`lstyle'"'=="" local lstyle lstyle(foreground)
    if `"`fcolor'"'=="" local fcolor fcolor(white)
    c_local fr_opts `lstyle' `fcolor' `options'
end

program parse_key
    // options
    foreach arg in minY maxY minX maxX p Ymin Yr Xmin Xr DY DX _Y _X _H _W/*
        */ _pstyle pline _options _TY _TX txw _TW _place _just _topts {
        gettoken `arg' 0 : 0
    }
    _parse comma txt  0 : 0
    syntax [, y(str) x(str) h(str) w(str) ty(str) tx(str) tw(str) Text(str)/*
        */ PSTYle(passthru) * ]
    parse_num y `y' // y, _y
    if       "`y'"!="" local _Y = `Ymin' + `y' * `Yr' / 100
    else if "`_y'"!="" local _Y = `_Y' * `_y'
    parse_num x `x' // x, _x
    if       "`x'"!="" local _X = `Xmin' + `x' * `Xr' / 100
    else if "`_x'"!="" local _X = `_X' * `_x'
    parse_num h `h' // h, _h
    if       "`h'"!="" local _H =  `h' * `Yr' / 100
    else if "`_h'"!="" local _H = `_H' *  `_h'
    parse_num w `w' // w, _w
    if       "`w'"!="" local _W =  `w' * `Xr' / 100
    else if "`_w'"!="" local _W = `_W' * `_w'
    parse_num ty `ty' // ty, _ty
    if       "`ty'"!="" local _TY =  `ty' * `Yr' / 100
    else if "`_ty'"!="" local _TY = `_TY' * `_ty'
    parse_num tx `tx' // tx, _tx
    if       "`tx'"!="" local _TX =  `tx' * `Xr' / 100
    else if "`_tx'"!="" local _TX = `_TX' * `_tx'
    parse_num tw `tw' // tw, _tw
    if       "`tw'"!="" local _TW =  `tw' * `Xr' / 100
    else if "`_tw'"!="" local _TW = `_tw' * `_TW'
    mata: extract_opts(("Y", "X", "H", "W", "TY", "TX", "TW"))
    foreach opt in Y X H W TY TX TW {
        if "``opt''"!="" numlist `"``opt''"', max(1)
    }
    parse_topts, `text' // returns place, just, topts
    foreach opt in Y X H W TY TX TW pstyle place just {
        if "``opt''"!="" continue
        local `opt' `"`_`opt''"'
    }
    local options `_options' `options'
    local topts `_topts' `topts'
    
    // collect symbols
    gettoken next : txt
    if inlist(`"`next'"', ".", "-") {
        gettoken next txt : txt
        local sym_n  0
        local hassym = `"`next'"'=="-"
    }
    else {
        local i 0
        while (1) {
            gettoken next : txt, match(par)
            if `"`par'"'!="" {
                local ++i
                gettoken sym_`i' txt : txt, match(par)
                continue
            }
            continue, break
        }
        local sym_n `i'
        if `sym_n' {
            local hassym 1
            local p = mod(`++p'-1, 15) + 1
        }
        else local hassym 0
    }
    
    // plot symbols
    local plots
    forv i=1/`sym_n' {
        parse_sym `p' `Ymin' `Yr' `Xmin' `Xr' `DY' `DX' `Y' `X' `H' `W'/*
            */ `"`pstyle'"' "`pline'" `"`options'"' `sym_`i'' // returns plot
        local plots `plots' `plot'
    }
    
    // collect label
    parse_txt `txt' // returns txt
    
    // plot label
    if `TX'>=. {
        if "`_tx'"!="" local txw = `txw' * `_tx' // update default factor
        local tx = `W' * `txw'
    }
    else local tx `TX'
    if (sign(`tx')*sign(`Xr'))<0 {
        if `"`place'"'=="" local place left
        if `"`just'"'==""  local just  right
        local tdir -1
    }
    else {
        if `"`place'"'=="" local place right
        if `"`just'"'==""  local just  left
        local tdir 1
    }
    if `hassym' {
        local ty = `Y' + `TY'
        local tx = `X' + `tx'
    }
    else {
        local ty = `Y'
        local tx = `X' - 0.5*`W'
    }
    setdim y = `ty' + `DY'
    setdim x = `tx' + `DX'
    local topts place(`place') just(`just') `topts'
    local plots `plots' (scatteri `y' `x', ms(i) text(`y' `x' `txt', `topts'))
    
    // update range of legend (ignoring individual symbol settings)
    local tmp "`Y'-0.5*`H', `Y'+0.5*`H', `ty'-0.5*`H', `ty'+0.5*`H'"
    local minY = min(`minY', `tmp')
    if `maxY'<. local tmp "`maxY',`tmp'"
    local maxY = max(`tmp')
    local tmp "`X'-0.5*`W', `X'+0.5*`W', `tx', `tx'+`tdir'*`TW'"
    local minX = min(`minX', `tmp')
    if `maxX'<. local tmp "`maxX',`tmp'"
    local maxX = max(`tmp')
    
    // returns
    foreach opt in p Y X H W TY TX txw TW minY maxY minX maxX plots {
        c_local `opt' ``opt''
    }
end

program parse_txt
    c_local txt `"`0'"'
    while (`"`0'"'!="") {
        gettoken tok 0 : 0, qed(qed)
        if `qed' continue
        di as err `"{bf:`tok'} found where quoted text expected"'
        exit 198
    }
end

program parse_sym
    // options
    foreach arg in p Ymin Yr Xmin Xr DY DX _Y _X _H _W _pstyle pline _options {
        gettoken `arg' 0 : 0
    }
    _parse comma SYM 0 : 0
    syntax [, y(str) x(str) h(str) w(str) PSTYle(passthru) * ]
    parse_num y `y' // y, _y
    if "`_y'"!="" local _y = `_H' * `_y' // treat *# as fraction key's height
    parse_num x `x' // x, _x
    if "`_x'"!="" local _x = `_W' * `_x' // treat *# as fraction of key's width
    parse_num h `h' // h, _h
    if       "`h'"!="" local _H =  `h' * `Yr' / 100
    else if "`_h'"!="" local _H = `_H' * `_h'
    parse_num w `w' // w, _w
    if       "`w'"!="" local _W =  `w' * `Xr' / 100
    else if "`_w'"!="" local _W = `_W' * `_w'
    mata: extract_opts(("Y", "X", "H", "W"))
    foreach opt in Y X H W {
        if "``opt''"!="" numlist `"``opt''"', max(1)
    }
    foreach opt in H W pstyle {
        if "``opt''"!="" continue
        local `opt' `"`_`opt''"'
    }
    if "`Y'"=="" {
        if "`y'"!=""       local Y = `y' * `Yr' / 100
        else if "`_y'"!="" local Y = `_y'
        else               local Y 0
    }
    local Y = `_Y' + `Y'
    if "`X'"=="" {
        if "`x'"!=""       local X = `x' * `Xr' / 100
        else if "`_x'"!="" local X = `_x'
        else               local X 0
    }
    local X = `_X' + `X'
    local options `_options' `options'
    parse_getpnum, `pstyle' // updates p
    parse_getopt MLABPosition, `options'
    parse_getopt LSTYle, `options'
    if `"`lstyle'"'!="" local lstyle
    else local lstyle lstyle(p`p'other) // used by spike, cap, capsym, custom
    
    // plot symbols
    if !`: list sizeof SYM' local SYM "."
    local plots
    setdim b = `Y' - 0.5 * `H' + `DY'
    setdim t = `Y' + 0.5 * `H' + `DY'
    setdim m = `Y' + `DY'
    setdim l = `X' - 0.5 * `W' + `DX'
    setdim r = `X' + 0.5 * `W' + `DX'
    setdim c = `X' + `DX'
    while (`"`SYM'"'!="") {
        local ptype
        local LTSYLE
        gettoken sym SYM : SYM, qed(istext) match(par)
        if `istext' { // "text" symbol
            if `"`mlabposition'"'=="" local plot (0)
            else                      local plot
            local plot scatteri `m' `c' `plot' `"`sym'"', ms(i)
        }
        else if "`par'"!="" {  // custom symbol
            capt n parse_coordinates `DY' `DX' `Y' `H' `X' `W' `sym' // plot
            if _rc==1 exit 1
            else if _rc {
                di as err "invalid symbol definition"
                exit _rc
            }
            local plot scatteri `plot', recast(line) nodropbase cmissing(n)
            local LSTYLE `lstyle'
        }
        else {
            if      `"`sym'"'=="rcap"    local sym "cap"
            else if `"`sym'"'=="rcapsym" local sym "capsym"
            if inlist(`"`sym'"',"line","vline") {
                if "`sym'"=="line" local plot `m' `l' `m' `r'
                else               local plot `b' `c' `t' `c'
                local plot scatteri `plot', recast(line)
                if "`pline'"!="" local ptype "line"
            }
            else if inlist(`"`sym'"',"spike","vspike") {
                if "`sym'"=="spike" local plot `m' `l' `m' `r'
                else                local plot `b' `c' `t' `c'
                local plot scatteri `plot', recast(line)
                local LSTYLE `lstyle'
            }
            else if inlist(`"`sym'"',"rline","vrline") {
                if "`sym'"=="rline" local plot `t' `l' `t' `r'/*
                                        */ . . `b' `l' `b' `r'
                else                local plot `b' `l' `t' `l'/*
                                        */ . . `b' `r' `t' `r'
                local plot scatteri `plot', recast(line) cmissing(n)
                if "`pline'"!="" local ptype "line"
            }
            else if inlist(`"`sym'"',"area") {
                local plot `b' `l' `b' `r' `t' `r' `t' `l'
                local plot scatteri `plot', recast(area) nodropbase
                local ptype "area"
            }
            else if inlist(`"`sym'"',"bar") {
                local plot `b' `l' `b' `r' `t' `r' `t' `l'
                local plot scatteri `plot', recast(area) nodropbase
                local ptype "bar"
            }
            else if inlist(`"`sym'"',"cap", "vcap") {
                if "`sym'"=="cap" local plot `m' `l' `m' `r', ms(|)
                else              local plot `b' `c' `t' `c', ms(|) msang(90)
                local plot scatteri `plot' recast(connect)
                local LSTYLE `lstyle'
            }
            else if inlist(`"`sym'"',"capsym", "vcapsym") {
                if "`sym'"=="capsym" local plot `m' `l' `m' `r'
                else                 local plot `b' `c' `t' `c'
                local plot scatteri `plot', recast(connect)
                local LSTYLE `lstyle'
            }
            else { // marker symbol
                local plot ms(`sym')
                if `"`sym'"'=="." local plot
                local plot scatteri `m' `c', `plot'
            }
        }
        if `"`pstyle'"'=="" local PSTYLE pstyle(p`p'`ptype') `LSTYLE'
        else                local PSTYLE `pstyle' `LSTYLE'
        local OPTIONS `PSTYLE' `options'
        local plots `plots' (`plot' `OPTIONS')
    }
    
    // returns
    c_local plot `plots'
end

program parse_getpnum
    syntax [, PSTYle(str) ]
    if regexm(`"`pstyle'"', "^p([1-9][0-9]*)") {
        c_local p = regexs(1)
    }
end

program parse_getopt
    _parse comma OPT 0 : 0
    syntax [, `OPT'(passthru) * ]
    local opt = strlower("`OPT'")
    c_local `opt' `"``opt''"'
end

program parse_num // # vs *#
    gettoken nm 0 : 0
    gettoken star : 0, parse("*")
    if `"`star'"'=="*" {
        local 0 = substr(`"`0'"', strpos(`"`0'"', "*")+1, .)
        numlist `"`0'"', max(1)
        c_local `nm' ""
        c_local _`nm' `r(numlist)'
        exit
    }
    numlist `"`0'"', min(0) max(1)
    c_local `nm' `r(numlist)'
    c_local _`nm' ""
end

program parse_coordinates
    gettoken DY 0 : 0
    gettoken DX 0 : 0
    gettoken Y  0 : 0
    gettoken H  0 : 0
    gettoken X  0 : 0
    gettoken W  0 : 0
    local h = `H' / 2
    local w = `W' / 2
    numlist `"`0'"', min(2) missingok
    local yx `r(numlist)'
    local n: list sizeof yx
    if mod(`n',2) error 122
    local n = `n' / 2
    local plot
    forv i = 1/`n' {
        gettoken y yx : yx
        setdim y = `Y' + `y' * `h' + `DY'
        gettoken x yx : yx
        setdim x = `X' + `x' * `w' + `DX'
        local plot `plot' `y' `x'
    }
    c_local plot `plot'
end

program setdim // avoid too many digits
    gettoken nm 0 : 0
    local x `0'
    if abs(`x')>=10^8 c_local `nm' = round(`x')
    else              c_local `nm' = strofreal(`x', "%10.0g")
end

version 14
mata:
mata set matastrict on

void extract_opts(string rowvector O)
{
    string scalar    opt, arg, options
    transmorphic     t
    
    t = tokeninit(" ", "", "()")
    tokenset(t, st_local("options"))
    options = ""
    while ((opt = tokenget(t))!="") {
        arg = tokenpeek(t)
        if (_token_has_pars(arg)) { // option has arguments
            (void) tokenget(t)
            if (anyof(O, opt)) { // match found; extract option
                st_local(opt, strtrim(substr(arg, 2, strlen(arg)-2)))
                continue
            }
            options = options + " " + opt + arg
            continue
        }
        options = options + " " + opt
    }
    st_local("options", substr(options, 2, .))
}

real scalar _token_has_pars(string scalar s)
{   // 1 if "(...)", 0 else
    if (substr(s,1,1)=="(") {
        if (substr(s,-1,1)==")") return(1)
        return(0)
    }
    return(0)
}

void keys_expand()
{
    real scalar   i, a, b, par, opts, newkey
    string scalar s, tok
    transmorphic  t
    
    s = st_global("s(after)")
    t = tokeninit(" ", (",", "||"), (`""""', `"`""'"', "()"))
    tokenset(t, s)
    newkey = opts = par = i = 0
    b = 1
    while ((tok = tokenget(t))!="") {
        if (_token_has_pars(tok)) {
            if (opts==par) newkey = 1 /* start new key it token is "(...)" and
                one of the following cases applies: (1) the position of the
                token is not in a section of options and the token is not
                preceded by "(...)" (2) the position of the token is in a
                section of options and it is preceded by "(...)" */
            par = 1 // remember that token is "(...)" for the next loop
        }
        else {
            par = 0 // remember that token is not "(...)" for the next loop
            if      (tok==".") newkey = 1  // heading
            else if (tok=="-") newkey = 1  // subheading
            else if (tok==",") {
                if (opts) newkey = 1       // repeated set of options
                else      opts = par = 1   // start of options, i.e. ", ..."
            }
            else if (tok=="||") newkey = 2 // explicit key delimiter
        }
        if (newkey) {
            a = b; b = tokenoffset(t)
            opts = 0
            if (newkey==2) { // (explicit delimiter)
                _keys_expand(i, s, a, b-a-2) // extract key (w/o delimiter)
                tok = tokenpeek(t)
                if (tok!="||") { // move to first token after delimiter
                    tok = tokenget(t)
                    if (_token_has_pars(tok)) par  = 1 // token is "(...)"
                    else if (tok==",")        opts = 1 // start of options
                }
            }
            else { // (implicit delimiter)
                b = b - strlen(tok)
                _keys_expand(i, s, a, b-a) // extract key
            }
            newkey = 0
        }
    }
    _keys_expand(i, s, b, .) // extract last key
    st_local("key_n", strofreal(i))
}

void _keys_expand(real scalar i, string scalar s, real scalar a, real scalar l)
{
    string scalar tok
    
    tok = strtrim(substr(s, a, l))
    if (tok!="") {
        i++
        st_local("key_"+strofreal(i), tok)
    }
}

end

