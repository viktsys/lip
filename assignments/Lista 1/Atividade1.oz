% Atividade 1
% Aluno: Carlos Victor M. da Silva
% Matricula: 476516


/* Questão 1 */

% Item a) 
/* 
   Calculate the exact value of 2^100 without using any new functions. Try
   to think of short-cuts to do it without having to type 2*2*2*...*2
   with one hundred 2’s. 
   Hint: use variables to store intermediate results. 
*/

% Resultado esperado: 1.2676506e+30 || 1267650600228229401496703205376

declare 
    B = 2               % Base
    E = 100             % Expoente
    R = {NewCell B}     % Resultado, durante a execução é tambem responsável 
                        % por armazenar o valor enquanto é computado

if E==0 then            % Se o expoente for 0 então...
    if B\=0 then        % Se B for diferente de 0 então...
        R := 1
        {Browse @R} % {Show @R}
    else                % Ambos os valores são 0, logo...
        {Browse 'Erro: Não é possivel calcular 0 ^ 0'}
    end
else                    % Se não (há necessidade de executar cálculos)
    for _ in 1..E-1 do
        R := @R * B
    end
    {Browse @R} % {Show @R}
end


% Item b)
/*
    Calculate the exact value of 100! without using any new functions. 
    Are there any possible short-cuts in this case?
*/

% Resultado esperado: 9.332622e+157 

declare 
    N = {NewCell 100}   % Número
    Fat = {NewCell 1}   % Resultado final e armazenamento temporario

for I in 1..@N do
    Fat := @Fat * I
end

{Browse @Fat} % {Show @Fat} 


/* Questão 2 */

% Item a)
/*
    As a first step, use the following alternative definition to write a more efficient function:

                       n * (n-1) * (n-2) * ... * (n - r + 1)
    Comb (n, r) =  ---------------------------------------------
                           r * (r-1) * (r-2) * ... * 1

    Calculate the numerator and denominator separately and then divide them. 
    Make sure that the result is 1 when r = 0.
*/

declare
fun {Fact N}
   R = {NewCell 1}
in
   for I in 1..N do
      R := @R * I
   end
   @R
end

declare
fun {Comb N R} Up Down in
    if R==0 then 1
    else 
        Up = {NewCell {Fact (N-R)}}
        Down = {NewCell {Fact R}}
        @Up div @Down
    end
end

{Browse {Comb 16 0}}   % Esperado: 1
{Browse {Comb 16 4}}   % Esperado: 19958400


% Item b)
/* 
    As a second step, use the following identity:
   
    Comb(n, r) = Comb(n, n - r)

    To increase efficiency even more. 
    That is, if r > n/2 then do the calculation with n − r instead of with r.

*/

declare
fun {NComb N R}
    if R==0 then 1 else 
        if R > (N / 2) then 
            {Comb N N-R} 
        else
            {Browse 'R is lesser then N / 2'}
            {Comb N R}
        end
    end
end

{Browse {NComb 10 0}}
{Browse {NComb 10 4}}
{Browse {NComb 10 8}}




/* Questão 5 */
declare Ints
fun lazy {Ints N}
   N|{Ints N+1}
end

declare 
fun {SumList L}
    case L of X|L1 then X+{SumList L1} 
    else 0 end
end

declare 
fun lazy {LazySumList L}
    case L of X|L1 then X+{SumList L1} 
    else 0 end
end

{Browse {LazySumList {Ints 0}}} % Irá escrever "_" no Oz Browser
{Browse {SumList {Ints 0}}}     % Irá estourar a memória disponivel alocada e irá encerrar a maquina virtual


/* Questão 6 */

% Item a)
/*
     Calculate individual rows using subtraction, multiplication, and other operations. 
     Why does using multiplication give a triangle with all zeroes? Try the following 
     kind of multiplication instead:

        fun {Mul1 X Y} (X+1)*(Y+1) end
    
    * What does the 10th row look like when calculated with Mul1?
*/

declare GenericPascal ShiftLeft ShiftRight Mul1 OpList

fun {Mul1 X Y} (X+1)*(Y+1) end

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

fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L = {GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

{Browse {GenericPascal Mul1 10 }}

% Item b)
/* 
    The following loop instruction will calculate and display 10 rows at a time:
        
        for I in 1..10 do {Browse {GenericPascal Op I}} end
    
    * Use this loop instruction to make it easier to explore the variations.
*/

for I in 1..10 do {Browse {GenericPascal Mul1 I}} end

/* Questão 8 */
/*
    This exercise investigates how to use cells together with functions. Let us define a function {Accumulate N} 
    that accumulates all its inputs, i.e., it adds together all the arguments of all calls. Here is an example:
        
        {Browse {Accumulate 5}}
        {Browse {Accumulate 100}}
        {Browse {Accumulate 45}}
    
    This should display 5, 105, and 150, assuming that the accumulator contains zero at the start. 
    Here is a wrong way to write Accumulate:
    
        declare
        fun {Accumulate N}
            Acc in
                Acc={NewCell 0}
                Acc:=@Acc+N
            @Acc
        end
    
    What is wrong with this definition? How would you correct it?
*/

% Codigo incorreto
declare
fun {NotCorrectAccumulate N}
    Acc in
        Acc={NewCell 0}
        Acc:=@Acc+N
    @Acc
end

{Browse {NotCorrectAccumulate 5}}       % Esperado: 5       Resultado: 5
{Browse {NotCorrectAccumulate 100}}     % Esperado: 105     Resultado: 100
{Browse {NotCorrectAccumulate 45}}      % Esperado: 150     Resultado: 45

% O que está errado? A cada chamada uma nova celula é definida, modificada mas nunca armazenada em nenhum lugar onde
%                    poderá ser acessada novamente por uma possivel futura chamada e assim garantir que o comportamento 
%                    esperado aconteça. 


% Codigo correto
local Acc Accumulate 
in
    Acc = {NewCell 0}
    Accumulate = fun {$ N}
                    Acc := @Acc + N
                    @Acc
                 end

    {Browse {Accumulate 5}}       % Esperado: 5
    {Browse {Accumulate 100}}     % Esperado: 105
    {Browse {Accumulate 45}}      % Esperado: 150
end

% Porque está funcionando? Ao mover a celula que armazena os valores e recebe os incrementos e depois é retornado para fora
%                          da função, garantimos que ela não será redefinida ao seu estado padrão a cada chamada (Acc = {NewCell 0})
%                          e garantimos o comportamento esperado, desde que esteja dentro do bloco



/* Questão 10 */

% Item a)
/* 
    Try executing this example several times. What results do you get?
    Do you ever get the result 1? Why could this be? 
*/

declare 
C = {NewCell 0}

thread
    C := 1
end

thread
    C := 2
end

{Show @C}

% Resposta: Sempre 0. PQ? A natureza não deterministica da linguagem Oz e pela natureza 
%           assincrona de uma Thread, pois não é possivel determinar quando será executado
%           o codigo ou a ordem que as threads serão executadas.

% Item b)
/*
    Modify the example by adding calls to Delay in each thread. This changes the thread interleaving without 
    changing what calculations the thread does. Can you devise a scheme that always results in 1?
*/
declare C = {NewCell 0}

thread I in
    {Delay 100}
    I=@C
    C:=I+1
end

thread J in
    J=@C
    C:=J+1
end

{Delay 10}
{Browse @C}


% Item c)
/* 
    Section 1.16 gives a version of the counter that never gives the result 1.
    What happens if you use the delay technique to try to get a 1 anyway?
*/

declare C = {NewCell 0}
declare L = {NewLock}

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

{Browse @C}

