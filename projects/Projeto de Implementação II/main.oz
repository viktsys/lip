% LIP - Projeto de Implementação II
% Aluno: Carlos Victor Martins da Silva
% Matricula: 476516

declare [Circuits] = {Module.link ['circuits.ozf']}
declare [Gates] = {Module.link ['gates.ozf']}

/* Teste das portas logicas */
local A B N in
    N = 1|0|_
    A = 1|0|1|0|_
    B = 1|1|0|0|_

    {Browse 'NOT'}
    {Browse {Gates.notG N}}
    
    {Browse 'AND'}
    {Browse {Gates.andG A B}}
   
    {Browse 'NAND'}
    {Browse {Gates.nandG A B}}

    {Browse 'OR'}
    {Browse {Gates.orG A B}}
   
    {Browse 'NOR'}
    {Browse {Gates.norG A B}}
    
    {Browse 'XOR'}
    {Browse {Gates.xorG A B}}
     
end


% Teste dos circuitos %
{Browse 'Circuito #1'}
local A B C R in 
    A = 1|1|0|0|0|0|_
    B = 1|0|1|1|0|0|_
    C = 1|1|1|0|1|0|_
    {Circuits.firstcircuit A B C R}
    {Browse R}
end

{Browse 'Circuito #2'}
local A B C R in
    A = 1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|_
    B = 1|1|1|1|0|0|0|0|1|1|1|1|0|0|0|0|_
    C = 1|1|0|0|1|1|0|0|1|1|0|0|1|1|0|0|_
    D = 1|0|1|0|1|0|1|0|1|0|1|0|1|0|1|0|_
    {Circuits.secondcircuit A B C D R}
    {Browse R} 
end

{Browse 'Circuito #3'}
local A B C D R in
    A = 1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|_
    B = 1|1|1|1|0|0|0|0|1|1|1|1|0|0|0|0|_
    C = 1|1|0|0|1|1|0|0|1|1|0|0|1|1|0|0|_
    D = 1|0|1|0|1|0|1|0|1|0|1|0|1|0|1|0|_
    {Circuits.thirdcircuit A B C D R}
    {Browse R}
end
