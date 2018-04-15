defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  @root true

  # Expressoes
  define :command, "atrib / exp"

  define :exp, "arithexp / boolexp / value"

  # Expressoes aritimeticas

  define :arithexp, "sum / sub / div / mul / rem"

  define :sum, "decimal  sumOp  arithexp / decimal  sumOp decimal"
  define :sub, "decimal  subOp  arithexp / decimal  subOp  decimal"
  define :div, "decimal  divOp  arithexp / decimal  divOp  decimal"
  define :mul, "decimal  mulOp  arithexp / decimal  mulOp  decimal"
  define :rem, "decimal  remOp  arithexp / decimal  remOp  decimal"

  # Operações Booleanas
  define :boolexp, "equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals,     "value notEqualsOp     value"
  define :equals,        "value equalsOp        value"
  define :greater,       "value greaterOp       value"
  define :less,          "value lessOp          value"
  define :greaterEquals, "value greaterEqualsOp value"
  define :lessEquals,    "value lessEqualsOp    value"
  define :notExp,        "notOp boolexp"

  define :notOp, "[~]"

  # Value

  define :value, "decimal / exp"

  # Numeros

 define :decimal, "decimalP / decimalN" do
    digitis -> Enum.join(digitis)
  end

  define :decimalP, "digit+"

  # Aqui temos que checar se a implementação correta é usando minus ou <minus>, observar mudanças
  # na arvore com os dois casos diferentes

  define :decimalN, "subOp digit+"

  # Digito

  define :digit, "[0-9]"

  # Espaços

  define :space, "[ \\r\\n\\s\\t]*"

  # Operadores Aritmeticos

  define :sumOp, "<space?> [+] <space?>"  do
    [x] -> x
  end
  define :subOp, "<space?> [-] <space?>" do
    [x] -> x
  end
  define :mulOp, "<space?> [*] <space?>" do
    [x] -> x
  end
  define :divOp, "<space?> [/] <space?>" do
    [x] -> x
  end
  define :remOp, "<space?> [%] <space?>" do
    [x] -> x
  end

  # Operadores Booleanos

  define :equalsOp, "<space?> [=][=] <space?>" do
    x -> Enum.join(x)
  end
  define :notEqualsOp, "<space?> [!][=] <space?>" do
    x -> Enum.join(x)
  end
  define :greaterOp, "<space?> [>] <space?>" do
    x -> Enum.join(x)
  end
  define :greaterEqualsOp, "<space?> [>][=] <space?>" do
    x -> Enum.join(x)
  end
  define :lessOp, "<space?> [<] <space?>" do
    x -> Enum.join(x)
  end
  define :lessEqualsOp, "<space?> [<][=] <space?>" do
    x -> Enum.join(x)
  end

  # Atribuição

  define :atrib, "varName atrOp value"

  define :varName, "word"

  #Usar letter e digit está caindo em recurão infinita
  #TODO: Mudar a regra a-zA-Z0-9 para letter,digit*
  define :word, "letter[a-zA-Z0-9]*" do
    letter -> Enum.join(letter)
  end

  define :letter, "[a-zA-Z]"

  #Quando usa [] cai em loop infinito
  #TODO: Verificar pq
  define :atrOp, "<space?> [:][=] <space?>"

end
