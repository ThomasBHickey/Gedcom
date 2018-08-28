load 'regex'
load '~Projects/gedcom/init.ijs'
NB. data=: fread 'c:\Users\Thomas\Downloads\HickeyFamilyTree.ged'
NB. data=: fread 'c:\Users\Thomas\Downloads\Hickey-Cherney-Family-Tree.ged'
NB. data=: fread 'd:\Family\Legacy\test1000.ged'
NB. data=: fread 'd:\Family\Legacy\Hickey-Cherney_Family_Tree_20170410.ged'
NB. data =: fread 'd:\Family\Legacy\DannerHickeyMerge.ged'
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

'levs1 ptrs1 tags1 vals1' =. parseGED AncData1
'levs2 ptrs2 tags2 vals2' =. parseGED AncData2

names1 =. (tags1=<'NAME') #vals1
names2 =. (tags2=<'NAME') #vals2

lev0x1 =: ('0' = 0{"1>AncData1)
lev0lines1 =: lev0x1 # AncData1
NB. Number of tags
#(~:tags1) # tags1
#(~:tags2) # tags2


