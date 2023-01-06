% UFC - Linguagens de Programação - Lista 2
% Carlos Victor Martins da Silva - 476516

% 1.
proc {P X}
    if X>0 then {P X-1} end
end

P = proc {$ X}
    		if X>0 then {P X-1} end
end

% 2.

% a)
declare A = 10 
declare B

local MulByn in
    
    local N in
        N = 3
        proc {MulByn X ?Y}
	        Y = N * X
        end
    end

    {MulByn A B}
    {Browse B} % Resultado: 30
    {Browse N} % Resultado: 3

end

% b)

declare A = 10 
declare B
declare N = 9

local MulByn in
    
    % N presente
    local N A B in
        N = 3
        proc {MulByn X ?Y}
	        Y = N * X
        end
    
        A = 10
        {MulByn A B}
        {Browse B} % Resultado: 30
        {Browse N} % Resultado: 3
    end

    % N presente fora da declaração do procedimento
    {MulByn A B}
    {Browse B} % Resultado: 30
    {Browse N} % Resultado: 9

    % N presente declarado dentro de um escopo local isolado 
    % e sobrescrevendo o valor presente na declaração de N
    local N in
        N = 100
        {MulByn A B}
        {Browse B} % Resultado: 30
        {Browse N} % Resultado: 100
    end

end


% 3.
declare
fun {Test X}
    if X then true else false end
end

% Caso 1: Funciona
try 
    {Browse {Test true}} % True
catch X then
    {Browse X}
end

% Caso 2: Não funciona
try 
    {Browse {Test 1}} % ERRO
catch X then
    {Browse X}
end

% 4.

% a)
if X then <s>¹ else <s>² end ::= case X
                                    of true then
                                        <s>¹
                                    [] else
                                        <s>²
                                    end

% b)
case <x> of <label>(<feat>1:<x>1 ... <feat>n:<x>n) then <s>1 else <s>2 end ::=

if {Label <x>}==<label> then
   if {Arity <x>}==[<feat>1 ... <feat>n] then
      local <x>1=<x>.<feat>1 ... <x>n=<x>.<feat>n in <s>1 end
   else <s>2 end
else <s>2 end

% 5.
proc {Test X} 
    case X of 
        a|Z then {Browse ´case´(1)} 
        [] f(a) then {Browse ´case´(2)} 
        [] Y|Z andthen Y==Z then {Browse ´case´(3)} 
        [] Y|Z then {Browse ´case´(4)} 
        [] f(Y) then {Browse ´case´(5)} 
        else {Browse ´case´(6)} 
    end 
end

declare Test
    proc {Test X}
        case X of '|'(a Z) then 
                {Browse 'case'(1)}
        else
            case X of f(a) then 
                {Browse 'case'(2)}
            else
            case X of '|'(Y Z) then
                if Y==Z then 
                    {Browse 'case'(3)}
                else 
                    case X of '|'(Y Z) then 
                        {Browse 'case'(4)}
                    else
                        case X of f(Y) then 
                            {Browse 'case'(5)}
                        else
                            {Browse 'case'(6)}
                        end
                    end
                end
            else
                case X of '|'(Y Z) then 
                        {Browse 'case'(4)}
                else
                    case X of f(Y) then 
                            {Browse 'case'(5)}
                    else
                            {Browse 'case'(6)}
                    end
                end
            end
        end
    end
end

{Test [b c a]}          % Resultado: 4
{Test f(b(3))}          % Resultado: 5
{Test f(a)}             % Resultado: 2
{Test f(a(3))}          % Resultado: 5
{Test f(d)}             % Resultado: 5
{Test [a b c]}          % Resultado: 1
{Test [c a b]}          % Resultado: 4
{Test a|a}              % Resultado: 1
{Test ´|´(a b c)}       % Resultado: 6

% 6.

declare Test
proc {Test X}
    case X of f(a Y c) then 
        {Browse ´case´(1)}
    else 
        {Browse ´case´(2)} 
    end
end

declare X Y {Test f(a Y d)} 
% f(a Y1 d)  f(a Y2 c) ?  a  == a && d == c ?  = 'case'(2)

declare X Y {Test f(X Y d)} 
% f(x1 y1 d) f(a Y2 c) ?  x1 == a && c == d ?  = 'case'(2) then block

declare X Y
{Browse f (X Y a) == f (c d b)} % Resultado: false

declare X Y in
    if f(X Y d) == f(a Y c) then 
        {Browse ´case´(1)}
    else 
        {Browse ´case´(2)} 
    end
end                                 % Resultado: 'case'(2)

% 7.
declare Max3 Max5 
    proc {SpecialMax Value ?SMax} 
        SMax = fun {$ X} 
            if X > Value then X else Value 
        end 
    end 
    
    {SpecialMax 3 Max3} 
    {SpecialMax 5 Max5} 

    {Browse [{Max3 4} {Max5 4}]} % Resultado: [4 5]
end

% 10.
fun {SMerge Xs Ys} 
    case Xs#Ys 
        of nil#Ys then Ys 
        [] Xs#nil then Xs 
        [] (X|Xr)#(Y|Yr) then
            if X=<Y then
                X|{SMerge Xr Ys}
            else
                Y|{SMerge Xs Yr}
        end
    end
end

% Versão em linguagem núcleo  
declare SMerge R
SMerge = proc {$ Xs Ys ?S}
	        case Xs of nil then S = Ys
	        else
	            case Ys of nil then S = Xs
	            else
		            case Xs of X|Xr then
		                case Ys of Y|Yr then
			                if X=<Y then
                                local Mid in
                                    S = X|Mid
                                    {SMerge Xr Ys Mid}
                                end
			                else
                                local Mid in
                                    S = Y|Mid
                                    {SMerge Xs Yr Mid}
                                end
			                end
		                end
		            end
	            end
	        end
end

{SMerge 1 2 R}
{Browse R}

% 11.
declare IsEven IsOdd

fun {IsEven X} 
    if X==0 then 
        true 
    else 
        {IsOdd X-1} 
    end
end 

fun {IsOdd X} 
    if X==0 then 
        false 
    else 
        {IsEven X-1} 
    end
end
