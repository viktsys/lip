
{Browse 999*999}


















/* Vari�vel */
declare
V=999*999

{Browse V}

declare U
U = V

{Browse U}

U=V

declare
V = 3

{Browse V}

{Browse U}

V=3

{Browse V==U}

declare X Y

{Browse X==Y}

X=Y


{Browse X} {Browse Y}

X = 6


/* Fun��es */
{Browse 1*2*3*4*5*6*7*8*9*10}



declare
Fact = proc {$ N R}
	  if (N=0) R=1
	  else R1
	       {Fact N-1 R1}
	       R = N * R1
	  end
        end

declare
Fact = fun {$ N}
            if N==0 then 1 else N * {Fact N-1} end
        end

declare
fun {Fact N}
   if N==0 then 1 else N * {Fact N-1} end
end

declare R
R = {Fact 10}
{Browse R}

{Browse {Fact 100}}




declare
fun {Comb N R}
   {Fact N} div ({Fact R}*{Fact N-R})
end

{Browse {Comb 30 4}}

/* Listas */
{Browse [1 2 3 4]}

declare
L = [1 2 3 4]

{Browse L.1} /* cabe�a da lista (head)*/
{Browse L.2} /* cauda da lista (tail) */
{Browse L.2.2.2.1}

declare H T
H=L.1
T=L.2
{Browse H} {Browse T}


declare L2
L2=H|T
{Browse L2}

{Browse L2|L}

L=H|T

{Browse 1|nil}

{Browse [1 2]|[3]}

/* pattern matching */

declare
L=[5 6 7 8]
case L of H|T then {Browse H} {Browse T} end

/* Tri�ngulo de Pascal */

declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
   if N==1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}}
               {ShiftRight {Pascal N-1}}}
   end
end

fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end

fun {ShiftRight L} 0|L end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end

{Browse {Pascal 7}}

{Browse {Pascal 30}}

/* Optimizing Pascal */

declare FastPascal
fun {FastPascal N}
   if N==1 then [1]
   else L in
      L = {FastPascal N-1}
      {AddList {ShiftLeft L}
               {ShiftRight L}}
   end
end

{Browse {FastPascal 100}}

declare X = {FastPascal 100}
{Browse X.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.1}

/* Avalia��o Lazy ou Procastrinada ou Pregui�osa */

declare Ints
fun lazy {Ints N}
   N|{Ints N+1}
end

{Browse {Ints 5}}

declare X
X = {Ints 5}
{Browse X}

{Browse X.1}
{Browse X.2.2.2.2.2.2.2.2.2.1}


declare PascalList
fun lazy {PascalList Row}
   Row | {PascalList {AddList {ShiftLeft Row}
		              {ShiftRight Row}}}
end

declare L
L = {PascalList [1]}

{Browse L.2.2.2.1}

{Browse L}


{Browse X}
declare PascalList2
/* sem avalia��o lazy */
fun {PascalList2 N Row}
  if N==1 then [Row]
  else
     Row|{PascalList2 N-1
           {AddList {ShiftLeft Row}
                    {ShiftRight Row}}}
  end
end


{Browse {PascalList2 10 [1]}}

{Browse {PascalList2 11 [1]}}

/* fun��es de alta ordem */

declare GenericPascal OpList

fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L = {GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil end
end

declare Add Xor

fun {Add X Y} X+Y end
fun {Xor X Y} if X==Y then 0 else 1 end end

{Browse {GenericPascal Add 10}}
{Browse {GenericPascal Xor 10}} /* 0 se o n�mero � �mpar, 1 se � par*/






/* Threads */

thread P in
   P = {Pascal 30}
   {Browse P}
end
{Browse {Pascal 10}}


/* Vari�veis dataflow */

declare X
thread {Delay 10000} X=99 end
{Browse start} {Browse X*X}

declare X in
thread {Browse start} {Browse X*X} end
{Delay 10000} X=99

/* Estado */

declare
C = {NewCell 0}
C := @C + 1
{Browse @C}


declare
C={NewCell 0}
fun {FastPascal N}
   C := @C+1
   {GenericPascal Add N}
end

C := 0
{Browse {FastPascal 8}}
{Browse @C}

/* Objects */

declare
local C in
   C = {NewCell 0}
   fun {Bump}
      C := @C + 1
      @C
   end
   fun {Read}
      @C
   end
end

{Browse Bump}
{Browse Bump}

declare
fun {FastPascal N}
    {Browse {Bump}}
    {GenericPascal Add N}
end

/* Classes */

declare
fun {NewCounter}
  C Bump Read in
    C = {NewCell 0}
   fun {Bump}
      C := @C+1
      @C
   end
   fun {Read}
      @C
   end
   counter(bump:Bump read:Read)
end

declare 
Ctr1 = {NewCounter}
Ctr2 = {NewCounter}

{Ctr1.bump}
{Ctr2.bump}
{Ctr2.bump}
{Browse Ctr1.read}
{Browse Ctr2.read}

/* threads and state, together */

declare
C={NewCell 0}
thread
   C:=1
end
thread
   C:=2
end



declare
C={NewCell 0}
thread I in
   I=@C
   C:=I+1
end
thread J in
   J=@C
   C:=J+1
end

/* Travas */

declare
C={NewCell 0}
L={NewLock}
thread
	lock L then I in
		I=@C
		C:=I+1
	end
end
thread
	lock L then J in
		J=@C
		C:=J+1
	end
end












   