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

--data Carros :: [(String, String, Int)]

carros::[(String, String, Int)]
carros = [("Corsa", "GM", 2005), ("Fiesta", "Ford", 2008), ("Celta", "GM", 2003), ("Palio", "Fiat", 2010), ("Uno", "Fiat", 1995), ("Ka", "Ford", 2010)]

data Arvore = Null | Node Int Arvore Arvore

tree::Arvore
tree = Node 12 (Node 1 Null Null) (Node 15 (Node 16 Null Null) Null) 

somaArvore::Arvore->Int
somaArvore Null = 0
somaArvore (Node a b c) = a + somaArvore b + somaArvore c

somaArvoreL::Arvore->Int
somaArvoreL Null = 0
somaArvoreL (Node a b c) = somaArvore b + a + somaArvore c

tamanho::Arvore->Int
tamanho Null = 0
tamanho (Node val a b) = 1 + tamanho a + tamanho b

ocorrencias::Arvore -> Int -> Int
ocorrencias Null num = 0
ocorrencias (Node val a b) num 
	| val == num = 1 + ocorrencias a num + ocorrencias b num
	| otherwise = ocorrencias a num + ocorrencias b num   

uns = 1 : uns

somaOsDoisPrimeiros :: [Integer] -> Integer
somaOsDoisPrimeiros (a:b:x) = a+b


a = b + c
	where
		b = 1
		c = 2
d = a * 2

isPalindrome::[Char] -> Bool
isPalindrome xs = xs == (reverse xs)

count_leaves Null = 0
count_leaves (Node num Null Null) = 1
count_leaves (Node num left right) = count_leaves left + count_leaves right

