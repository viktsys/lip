declare GenericPascal ShiftLeft ShiftRight OpList Add

fun {GenericPascal Op N}
   if (N==1) then [1]
   else L in
      L = {GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end

fun {ShiftRight L} 0|L end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil end
end

fun {Add X Y} X+Y end

declare Xor
fun {Xor X Y} if (X==Y) then 0 else 1 end end 

{Browse {GenericPascal Xor 10}}


declare GenericSlowPascal
fun {GenericSlowPascal Op N}
   if (N==1) then [1]
   else
      {OpList Op {ShiftLeft {GenericSlowPascal Op N-1}}
                 {ShiftRight {GenericSlowPascal Op N-1}}}
   end
end

{Browse {GenericSlowPascal Add 100}}

thread P in
   P={GenericSlowPascal Add 50}
   {Browse P}
end
{Browse 99*99}

thread
   {Browse 1}
end
thread
   {Browse 2}
end


declare X in
thread {Delay 10000} X=99 end
{Browse start} {Browse X*X} {Browse 1}

declare X in
thread {Browse start} {Browse X*X} {Browse 1} end
{Delay 10000} X=99


declare
C = {NewCell 0}
C := @C + 1
{Browse @C}

declare FastPascal
C = {NewCell 0}
fun {FastPascal N}
   C := @C + 1
   {GenericPascal Add N}
end

{Browse {FastPascal 1}}
{Browse {FastPascal 2}}
{Browse {FastPascal 3}}
{Browse @C}


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


declare NewCounter
fun {NewCounter}
   C Bump Read in
   C = {NewCell 0}
   fun {Bump}
      C := @C + 1
      @C
   end
   fun {Read}
      @C
   end
   counter(bump:Bump read:Read)
end



declare
Ctrl1 = {NewCounter}
Ctrl2 = {NewCounter}
{Browse {Ctrl1.bump}}

