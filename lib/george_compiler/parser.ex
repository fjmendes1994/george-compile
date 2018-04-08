defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  @root true

  # Expressoes
  define :command, "atrib / exp"

  define :exp, "arithexp / boolexp / value"

  # Expressoes aritimeticas

  define :arithexp, "sum / sub / div / mul / rem / priorityExp"

  define :sum, "decimal <space?> <sumOp> <space?> arithexp / decimal <space?> <sumOp> <space?> decimal"

  define :sub, "decimal <space?> <subOp> <space?> arithexp / decimal <space?> <subOp> <space?> decimal"

  define :div, "decimal <space?> <divOp> <space?> arithexp / decimal <space?> <divOp> <space?> decimal"

  define :mul, "decimal <space?> <mulOp> <space?> arithexp / decimal <space?> <mulOp> <space?> decimal"

  define :rem, "decimal <space?> <remOp> <space?> arithexp / decimal <space?> <remOp> <space?> decimal"

  # Operações Booleanas
  define :boolexp, "equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals, "value <space?> <notEqualsOp> <space?> value"

  define :equals, "value <space?> <equalsOp> <space?> value"

  define :greater, "value <space?> <greaterOp> <space?> value"

  define :less, "value <space?> <lessOp> <space?> value"

  define :greaterEquals, "value <space?> <greaterEqualsOp> <space?> value"

  define :lessEquals, "value <space?> <lessEqualsOp> <space?> value"

  define :notExp, "<notOp> boolexp"

  # Value

  define :value, "priority / decimal / bool / exp"

  # Numeros

 define :decimal, "decimalP / decimalN" do
    digitis -> Enum.join(digitis)
  end

  define :decimalP, "digit+"

  # Aqui temos que checar se a implementação correta é usando minus ou <minus>, observar mudanças
  # na arvore com os dois casos diferentes
  
  define :decimalN, "<subOp> digit+"

  # Digito

  define :digit, "[0-9]"

  # Espaços

  define :space, "[ \\r\\n\\s\\t]*"

  # Valores prioritarios

  define :priority, "priorityArit / priorityExp"

  define :priorityArit, "<lp> arithexp <rp>"

  define :priorityExp, "<lp> exp <rp>"

  define :lp, "[(]"

  define :rp, "[)]"

  # Operadores Aritmeticos

  define :sumOp, "[+]"

  define :subOp, "[-]"

  define :mulOp, "[*]"

  define :divOp, "[/]"

  define :remOp, "[%]"

  # Booleano

  define :bool, "true / false"

  define :true, "true"

  define :false, "false"

  # Operadores Booleanos

  # Acho que não podemos usar isso pois na hora de gerar a BPLC não conseguiriamos diferenciar as operações.
  # define :boolOp, "equalsOp / notEqualsOp / higherOp / smallerOp"

  define :equalsOp, "equal equal"

  define :notEqualsOp, "notOp equal"

  define :greaterEqualsOp, "greaterOp equal"

  define :lessEqualsOp, "lessOp equal"

  define :greaterOp, "[>]"

  define :lessOp, "[<]"

  define :equal, "[=]"

  define :notOp, "[!]"

  # Atribuição

  define :atrib, "varName <space?> <atrOp> <space?> value"

  define :varName, "word/ word decimal*"

  define :word, "letter+" do
    letter -> Enum.join(letter)
  end

  define :letter, "[a-z, A-Z]"

  #Quando usa [] cai em loop infinito
  #TODO: Verificar pq
  define :atrOp, "<':='>"

end
