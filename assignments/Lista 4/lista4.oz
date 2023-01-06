% 1.

% Item a)

local B in                  % (1)
	
    thread B = true end     % (2)
	thread B = false end    % (3)
	if B then               % (4)
        {Browse yes}        % (5)
    end

    % B == True             % (6)
    % B == False            % (7)

end

% Item b)

local B in                                 % (1)
    
	B = {NewCell null}

    thread B := true end    % (2)
	thread B := false end    % (3)

	if @B then                             % (4)
        {Browse yes}                       % (5)
    end

    % B == True                            % (6)
    % B == False                           % (7)

end

/*------------------------------------------------*/
% 2.
local A B in
    proc {B _} 
        {Browse 'Esperando'}
        {Wait _} 
    end

    proc {A} 
        Collectible = {NewDictionary} 
        {Browse 'Definido'}
    in
        {B Collectible}
        {Browse 'Chamado'}
    end

    {A}
end
/*------------------------------------------------*/
% 3.

declare Fib ConcurrentFib Timer

fun {Fib X}
    if X =< 2 then 1
    else {Fib X-1} + {Fib X-2} end
end

fun {ConcurrentFib X}
    if X =< 2 then 1
    else 
        thread {Fib X-1} end + thread {Fib X-2} end 
    end
end

% fun {ElapsedTime P Size}
%     Start = {Time.time} Fin Result
% in
%     Result = {P Size}
%     Fin = {Time.time}
%     Fin - Start
% end

fun {Timer Proc Args}
    Start = {Time.time}
in
    local T in
        T = {Proc Args}
    end
    {Time.time} - Start
end

for I in 25..50 do
    {Browse "Fib(" # I # ") -" # {Timer Fib 10}} 
    {Browse "ConcurrentFib(" # I # ") -" # {Timer ConcurrentFib 10}} 
end

/*------------------------------------------------*/
% 4.

local A B C D in
    thread D=C+1 end
    thread C=B+1 end
    thread A=1 end
    thread B=A+1 end
    {Browse D}
end

local A B C D in
    A=1
    B=A+1
    C=B+1
    D=C+1
    {Browse D}
end

/*------------------------------------------------*/
% 7.

% Código do livro 
proc {DGenerate N ?Xs}
   case Xs
   of X|Xr then
      X = N
      {DGenerate N + 1 Xr}
   end
end

proc {DSum Xs ?A Limit}
   if Limit > 0 then
      X|Xr = Xs
   in
      {Dsum Xr A + X Limit - 1}
   else
      A
   end
end

local Xs S in
   thread {DGenerate 0 Xs} end
   thread S = {DSum Xs 0 1000} end
   {Browse S}
end

% Adaptação 

declare
proc {DGenerate N ?Xs}
    NextXs
    fun {NF}
        {DGenerate N+1 NextXs}
        NextXs
    end
in
    Xs = N#NF
end

fun {DSum Xs ?A Limit}
    if Limit > 0 then
        X#NF = {Xs}
    in
        {DSum NF A + X Limit - 1}
    else
        A
    end
end

local Xs S in
    {DGenerate 0 Xs}
    S = {DSum Xs.2 0 4096}
    {Browse S}
end

/*------------------------------------------------*/
% 5.

proc {Wait X} 
    if X == unit then 
        skip 
    else 
        skip 
    end 
end

/*------------------------------------------------*/
% 8.
declare
fun {Filter In F} 
    case In of X|In2 then 
        if {F X} then 
            X|{Filter In2 F} 
        else 
            {Filter In2 F} 
        end 
    else 
        nil
    end 
end 

{Show {Filter [5 1 2 4 0] fun {$ X} X>2 end}}

% a)
declare A 
{Show {Filter [5 1 A 4 0] fun {$ X} X>2 end}}

% b)
declare Out A
thread Out = {Filter [5 1 A 4 0] fun {$ X} X>2 end} end
{Show Out}

% c)
declare Out A 
thread Out = {Filter [5 1 A 4 0] fun {$ X} X>2 end} end 
{Delay 1000} 
{Show Out}

% d)
declare Out A 
thread Out = {Filter [5 1 A 4 0] fun {$ X} X>2 end} end 
thread A = 6 end 
{Delay 1000} 
{Show Out}


/*------------------------------------------------*/
% 10.
declare
fun lazy {Three} 
    {Delay 1000} 
    3 
end

{Three}+0 % {Browse {Three}+0}
{Three}+0 % {Browse {Three}+0}
{Three}+0 % {Browse {Three}+0}

%----------------LINGUAGEM NÚCLEO----------------%

declare Three A B C
Three = proc {$ ?X} 
            {Delay 1000}
            X=3
        end

{ByNeed Three A} P + 0
{ByNeed Three B} Q + 0
{ByNeed Three C} R + 0

/*------------------------------------------------*/

/*------------------------------------------------*/
% 11.
local MakeX MakeY MakeZ X Y Z in
    fun lazy {MakeX} {Browse x} {Delay 3000} 1 end
    fun lazy {MakeY} {Browse y} {Delay 6000} 2 end
    fun lazy {MakeZ} {Browse z} {Delay 9000} 3 end
    X = {MakeX}
    Y = {MakeY}
    Z = {MakeZ}

    %{Browse (X+Y)+Z} % Caso 1
    {Browse X+(Y+Z)} % Caso 2
    %{Browse thread X + Y end + Z} % Caso 3

    {FoldL Ls fun{$ X Y} thread X+Y end end 0}
end


/*------------------------------------------------*/

/*------------------------------------------------*/
% 15.
declare LAppend As Bs L
fun lazy {LAppend As Bs}
	case As
	of nil then Bs
	[] A|Ar then A|{LAppend Ar Bs}
	end
end

L = {LAppend "foo" "bar"}
{Browse L}

%----------------LINGUAGEM NÚCLEO----------------%
declare LAppend
proc {LAppend As Bs ?Rs}
	case As
        of nil then Bs
        [] A|Ar then
            local Next in
                Rs = A|Next
                {LAppend Ar Bs Next}
            end
        end
end

/*------------------------------------------------*/

% 18.
declare TryFinally

proc {TryFinally S1 S2} 
    B Y in 
        try {S1} B=false catch X then B=true Y=X end 
        {S2}
        if B then raise Y end end 
end

local U=1 V=2 in 
    {TryFinally 
        proc {$} 
            thread 
            {TryFinally proc {$} U=V end 
                proc {$} {Browse bing} end} 
            end 
        end 
        proc {$} {Browse bong} end} 
end

/*------------------------------------------------*/