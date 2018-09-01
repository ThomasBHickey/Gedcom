
stripBOM =: monad : 0
	if. (16bef 16bbb 16bbf{ a.) -: 3 {. y do.
		y =. 3 }. y
	end.
	y
)
maxTagLen =: 8

bxdlt =: 3 : '< (#~ ([: (+./\ *. +./\.) '' ''&~:)) y'
