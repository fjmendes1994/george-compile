defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  @root true

  # Expressoes

  define :exp, "arithexp"

  # Expressoes aritimeticas

  define :arithexp, "sum / sub / div / mul / rem"

  define :sum, "decimal <space?> <sumOp> <space?> arithexp / decimal <space?> <sumOp> <space?> decimal"

  define :sub, "decimal <space?> <subOp> <space?> arithexp / decimal <space?> <subOp> <space?> decimal"

  define :div, "decimal <space?> <divOp> <space?> arithexp / decimal <space?> <divOp> <space?> decimal"

  define :mul, "decimal <space?> <mulOp> <space?> arithexp / decimal <space?> <mulOp> <space?> decimal"

  define :rem, "decimal <space?> <remOp> <space?> arithexp / decimal <space?> <remOp> <space?> decimal"


   # Numeros

  define :decimal, "decimalP / decimalN" do
    digitis ->
      Enum.join(digitis)
  end

  define :decimalP, "digit+"

  # Aqui temos que checar se a implementação correta é usando minus ou <minus>, observar mudanças
  # na arvore com os dois casos diferentes
  define :decimalN, "<minus> digit+"

  # Sinal Negativo ( Temos que checar se havera problemas com o sinal de negativo)

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
end
