
declare X1 X2 Y1 Y2 in
thread {Browse X1} end
thread {Browse Y1} end

thread X1 = all | roads | X2 end
thread Y1 = all | roads | Y2 end
thread X2 = lead | to | rome | _ end
thread Y2 = lead | to | rhodes | _ end

declare X0 X1 X2 X3 in
thread
   Y0 Y1 Y2 Y3 
in
   {Browse [Y0 Y1 Y2 Y3]}
   Y0 = X0 + 1
   Y1 = X1 + Y0
   Y2 = X2 + Y1
   Y3 = X3 + Y2
   {Browse completed}
end

{Browse [X0 X1 X2 X3]}

X0=1
X1=2
X2=3
X3=4


declare ForAll
proc {ForAll L P}
	case L 
		of nil then skip
		[] X|L2 then {P X} {ForAll L2 P} 
	end
end

declare L 
thread {ForAll L Browse} end

declare L1 L2 
thread L = 1 | L1 end
thread L1 = 2 | 3 | L2 end
thread L2 = 4 | nil end

declare Map
fun {Map Xs F}
	case Xs 
	   of nil then nil
	   [] X|Xr then thread {F X} end | {Map Xr F}
	end
end

declare F Xs Ys Zs
{Browse thread {Map Xs F} end}

Xs = 1 | 2 | Ys
fun {F X} X*X end

Ys = 3 | Zs
Zs = nil

declare Fib
fun {Fib X}
   if X=<2
      then 1
      else thread {Fib X-1} end + {Fib X-2}
   end
end

{Browse {Fib 25}}

