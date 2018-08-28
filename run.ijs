load 'regex'
<<<<<<< HEAD
load '~Projects/gedcom/init.ijs'
NB. data=: fread 'c:\Users\Thomas\Downloads\HickeyFamilyTree.ged'
NB. data=: fread 'c:\Users\Thomas\Downloads\Hickey-Cherney-Family-Tree.ged'
=======
load '~Projects/Gedcom/init.ijs'
NB.data=: fread 'c:\Users\Thomas\Downloads\HickeyFamilyTree.ged'
NB.data=: fread 'c:\Users\Thomas\Downloads\Hickey-Cherney-Family-Tree.ged'
NB.data =: fread '~user/projects/Gedcom/samples/Hickey-CherneyFamilyTree2018.02.09.ged'
data =: fread '~user/projects/Gedcom/samples/donmouth.ged'
>>>>>>> 69526cc38a217c4c73ed37bac266a8ce47e24a15
NB. data=: fread 'd:\Family\Legacy\test1000.ged'
NB. data=: fread 'd:\Family\Legacy\Hickey-Cherney_Family_Tree_20170410.ged'
NB. data =: fread 'd:\Family\Legacy\DannerHickeyMerge.ged'
AncData1 =: (<;._2) toJ stripBOM fread jpath'~user/projects/Gedcom/samples/H-C 20180827.ged'
AncData2 =: (<;._2) toJ stripBOM fread jpath'~user/projects/Gedcom/samples/Butler_Sandleman_THickey.ged'

patc =: rxcomp '^([[:digit:]+]) (@[^@]+@ |)([[:alnum:]_]+) *(.*$|)'

parseGED =: monad : 0
<<<<<<< HEAD
	'lvevs ptrs tags vals' =. '';'';'';''
	NB.levs =. 0$0
	for_line. y do. NB. split data into boxed lines
		lineCount =. >: lineCount 
		NB.ubline =. >line
=======
	'ptrs tags vals' =. '';'';''
	levs =. 0$0
	lineCount =. 0
	for_line. y do.
		lineCount =. >: lineCount
>>>>>>> 69526cc38a217c4c73ed37bac266a8ce47e24a15
		m =. patc rxmatch >line
		'all lev ptr tag val' =. m rxfrom >line
		levs =. levs, ".>lev
		ptrs =. ptrs, ptr, LF
		tags =. tags, tag, LF
		vals =. vals, val, LF
		NB. if.lineCount=58 do.smoutput lineCount;line;lev;ptr;tag;val end.
	end.
	levs;((<;._2)ptrs);((<;._2)tags);<(<;._2)vals
)

'levs1 ptrs1 tags1 vals1' =. parseGED AncData1
'levs2 ptrs2 tags2 vals2' =. parseGED AncData2

names1 =. (tags1=<'NAME') #vals1
names2 =. (tags2=<'NAME') #vals2

<<<<<<< HEAD
lev0x1 =: ('0' = 0{"1>AncData1)
lev0lines1 =: lev0x1 # AncData1
NB. Number of tags
#(~:tags1) # tags1
#(~:tags2) # tags2
=======
NB. Top level lbines
lev0x =: ('0' = 0{"1>blines)
lev0blines =: lev0x # blines
NB. lev0ms =: lev0x # ms
NB. lev0startlength =:   (< (<a:), (< 3)) { lev0ms  NB.  tag pos,length
NB.    starts =. {."1 lev0startlength
NB.    lengths =. }."1 lev0startlength
smoutput (#~.tags); 'Different tags found'
>>>>>>> 69526cc38a217c4c73ed37bac266a8ce47e24a15
