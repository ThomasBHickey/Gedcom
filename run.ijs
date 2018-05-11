load 'regex'
load '~Projects/gedcom/init.ijs'
NB.data=: fread 'c:\Users\Thomas\Downloads\HickeyFamilyTree.ged'
data=: fread 'c:\Users\Thomas\Downloads\Hickey-Cherney-Family-Tree.ged'
NB. data=: fread 'd:\Family\Legacy\test1000.ged'
NB.data=: fread 'd:\Family\Legacy\Hickey-Cherney_Family_Tree_20170410.ged'
NB. data =: fread 'd:\Family\Legacy\DannerHickeyMerge.ged'

jdata =: toJ stripBOM data
blines =: (<;._2) jdata  NB. split into boxed lines

NB. (Level)(Opt. Pointer)(Tag)(Opt. Value)
patc =: rxcomp '^([[:digit:]+]) (@[^@]+@ |)([[:alnum:]_]+) *(.*$|)'

parseGED =: monad : 0
	'ptrs tags vals' =. '';'';''
	levs =. 0$0
	for_line. y do.
		lineCount =. >: lineCount 
		NB.ubline =. >line
		m =. patc rxmatch >line
		'all lev ptr tag val' =. m rxfrom >line
		levs =. levs, ".>lev
		ptrs =. ptrs, ptr, LF
		tags =. tags, tag, LF
		vals =. vals, val, LF
	end.
	levs;((<;._2)ptrs);((<;._2)tags);<(<;._2)vals
)

'levs ptrs tags vals' =. parseGED blines

names =. (tags=<'NAME') #vals

NB. Top level lbines
lev0x =: ('0' = 0{"1>blines)
lev0blines =: lev0x # blines
lev0ms =: lev0x # ms
lev0startlength =:   (< (<a:), (< 3)) { lev0ms  NB.  tag pos,length
   starts =. {."1 lev0startlength
   lengths =. }."1 lev0startlength
NB. nub of tags: ~:tags
