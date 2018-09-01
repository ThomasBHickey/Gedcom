load 'regex'
load '~Projects/gedcom/init.ijs'

AncData1 =: (<;._2) toJ stripBOM fread jpath'~user/projects/Gedcom/samples/H-C 20180827.ged'
AncData2 =: (<;._2) toJ stripBOM fread jpath'~user/projects/Gedcom/samples/Butler_Sandleman_THickey.ged'

patc =: rxcomp '^([[:digit:]+]) (@[^@]+@ |)([[:alnum:]_]+) *(.*$|)'

parseGED =: monad : 0
	'lvevs ptrs tags vals' =. '';'';'';''
	NB.levs =. 0$0
	for_line. y do. NB. split data into boxed lines
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

'levs1 ptrs1 tags1 vals1' =. [parsed1 =. parseGED AncData1
'levs2 ptrs2 tags2 vals2' =. [parsed2 =. parseGED AncData2

matchParsed =: dyad : 0
	'xlevs xptrs xtags xvals' =. x
	'ylevs yptrs ytags yvals' =. y
	smoutput 'found'; (+/~:xtags);'xtags'
	smoutput 'and  '; (+/~:ytags);'ytags'
	xnames =. (xtags=<'NAME') # xvals
	ynames =. (ytags=<'NAME') # yvals
	smoutput (#xnames); 'xnames'
	smoutput (#ynames); 'ynames'
	exact =: xnames i. ynames
	smoutput (+/exact<#xnames); 'exact matches'
	xlcnames =. bxdlt"1 tolower >xnames
	smoutput 'xlcnames';2{.xlcnames
	ylcnames =. bxdlt"1 tolower >ynames
	smoutput 'xlcnames';10{.xlcnames
	smoutput 'ylcnames';10{.ylcnames
	lcexact =: xlcnames i. ylcnames
	smoutput (+/lcexact<#xnames); 'lc exact matches'
	smoutput '#lcexact';#lcexact
	smoutput 'lcmatches'; lcexact # ynames
)

parsed1 matchParsed parsed2

names1 =. (tags1=<'NAME') #vals1
names2 =. (tags2=<'NAME') #vals2


lev0x1 =: ('0' = 0{"1>AncData1)
lev0lines1 =: lev0x1 # AncData1
NB. Number of tags
#(~:tags1) # tags1
#(~:tags2) # tags2


t2 =. [t1 =. 3