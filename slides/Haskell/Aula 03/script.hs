data Arvore = Null|Node int int Arvore Arvore

DepthFirst :: Arvore
DepthFirst Null = Null++['a']
DepthFirst (Node Key Value Left Right)
	|Left!=Null and Right==Null = DepthFirst (Left a b c d)
	|Right==Null and Left!=Null = DepthFirst (Right a b c d)