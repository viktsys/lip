idade :: Int
idade = 17

incrementa :: Int -> Int
incrementa n = n+1

mini :: Int -> Int -> Int
mini a b
	|a<=b = a
	|otherwise = b

(&&&) :: Int -> Int -> Int

a &&& b
	| a < b = a
	| otherwise = b

type Nome = String 

type Idade = Int 

verIdade :: (Nome, Idade) -> Idade 
verIdade (a,b) = b 

fatorial :: Int -> Int
fatorial 0 = 1
fatorial n = n * fatorial (n-1)

fib :: Int -> Int
fib n
	|n == 0 = 0
	|n == 1 = 1
	|otherwise = fib(n-1) + fib(n-2)

lista = [1..10]

somaLista [] = 0
somaLista (x:xs) = x + somaLista xs

duplica :: Int -> Int
duplica x = 2 * x

carros::[(String, String, Int)]
carros = [("Corsa", "GM", 2005), ("Fiesta", "Ford", 2008), ("Celta", "GM", 2003), ("Palio", "Fiat", 2010), ("Uno", "Fiat", 1995), ("Ka", "Ford", 2010)]