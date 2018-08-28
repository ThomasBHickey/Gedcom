load 'regex'
load '~Projects/gedcom/init.ijs'
data=: fread 'd:\Family\Legacy\HickeyFamilyTree.ged'
NB. data=: fread 'd:\Family\Legacy\test1000.ged'
NB.data=: fread 'd:\Family\Legacy\Hickey-Cherney_Family_Tree_20170410.ged'
NB.data =: fread 'd:\Family\Legacy\DannerHickeyMerge.ged'

jdata =: toJ stripBOM data
blines =: (<;._2) jdata  NB. split into boxed lines

NB. (Level)(Opt. Pointer)(Tag)(Opt. Value)
patc =: rxcomp '^([[:digit:]]) (@[^@]+@ |)([[:alnum:]_]+) *(.*$|)'

parseGED =: monad : 0
	ms =. 0 5 2 $ 0   NB. matches
	ptrs =. 0 2 $ 0
	lvls =. 0$0
	tags =. 0 4$0
	vals =. ''
	for_line. y do.
		ubline =. >line
		m =. patc rxmatch ubline
		NB. 'allp alll levp levl ptrp ptrl tagp tagl valp vall' =. , m
		'levp levl ptrp ptrl tagp tagl valp vall' =. ,1 2 3 4{ m
		lvls =. lvls, ". levl{. levp}. ubline
		if. tagl>maxTagLen do. display 'tag too long'; line_index end.
		tags =. tags, maxTagLen{. tagl{. tagp}. ubline
		vals =. vals,            (vall{. valp}. ubline), LF
		ms =. ms , m
		if. ptrl>0 do.
			ptrs =. ptrs, (line_index); (ptrl{. ptrp}. ubline)
		end.
	end.
	ms;ptrs;lvls;vals;<tags
)
'ms ptrs lvls vals tags' =: parseGED blines
vals =. (<;._2) vals
lev0blines =: (0=lvls) # blines
lev0ms =: lev0x # ms
lev0startlength =:   (< (<a:), (< 3)) { lev0ms  NB.  tag pos,length
starts  =. {."1 lev0startlength
lengths =. }."1 lev0startlength
