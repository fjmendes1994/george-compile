defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  @root true

  # Expressoes

  define :exp, "arithexp / boolexp"

  # Expressoes aritimeticas

  define :arithexp, "sum / sub / div / mul / rem"

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

  define :value, "decimal / bool / exp"

  # Numeros

 define :decimal, "decimalP / decimalN" do
    digitis -> Enum.join(digitis)
  end

  define :decimalP, "digit+"

  # Aqui temos que checar se a implementação correta é usando minus ou <minus>, observar mudanças
  # na arvore com os dois casos diferentes
  define :decimalN, "minus digit+"

  # Sinal Negativo ( Temos que checar se havera problemas com o operador de subtração )
  define :minus, "[-]"

  # Digito

  define :digit, "[0-9]"

  # Espaços

  define :space, "[ \\r\\n\\s\\t]*"

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


end
