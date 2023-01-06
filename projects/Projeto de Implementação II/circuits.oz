functor
import
    Gates at 'gates.ozf'
export 
    firstcircuit:FirstCircuit
    secondcircuit:SecondCircuit
    thirdcircuit:ThirdCircuit

define FirstCircuit SecondCircuit ThirdCircuit

    % Circuito #1 - ((C and B)) xor (B or A)))
    proc {FirstCircuit A B C ?R} 
        R = {Gates.xorG {Gates.orG B {Gates.andG C B}} {Gates.orG B A}}
    end

    % Circuito #2 - ~(A or B) and (C xor (A or ~D))
    proc {SecondCircuit A B C D ?R} 
        X Y Z
    in
        X = {Gates.notG {Gates.orG A B}}
        Y = {Gates.orG A {Gates.notG D}}
        Z = {Gates.xorG C Y}
        R = {Gates.andG X Z}
    end

    % Circuito #3 - ((A or B) xor (C or D)) nand C
    proc {ThirdCircuit A B C D ?R} 
        R = {Gates.nandG {Gates.xorG {Gates.orG A B} {Gates.orG C D}} C}
    end

end