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
  define :boolexp, "equals"

  define :equals, "value <space?> <boolOp> <space?> exp / value <space?> <boolOp> <space?> value"

  # Value

  define :value, "decimal / bool"

  # Numeros

  #TODO VERIFICAR SE É <subOp?> OU subOp?, POIS NÃO SABEMOS SE NA ÁRVORE DEVE REPRESENTAR O SINAL NEGATIVO 

  define :decimal, "<subOp?> digit+" do
    digits ->
      Enum.join(digits)
  end

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

  define :boolOp, "equalsOp / notEqualsOp / higherOp / smallerOp"

  define :equalsOp, "equal equal"

  define :notEqualsOp, "not equal"

  define :higherOp, "higher equal?"

  define :smallerOp, "smaller equal?"

  define :higher, "[>]"

  define :smaller, "[<]"

  define :equal, "[=]"

  define :not, "[!]"


end
