defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  @root true

  # Expressoes
  define :CommandDecl, "atrib / Expression"

  define :Expression, "ExpressionDecl / PredicateDecl / value"

  # Expressoes aritimeticas

  define :ExpressionDecl, "sum / sub / div / mul / rem"

  define :sum, "ident  sumOp  ExpressionDecl / ident  sumOp ident"
  define :sub, "ident  subOp  ExpressionDecl / ident  subOp  ident"
  define :div, "ident  divOp  ExpressionDecl / ident  divOp  ident"
  define :mul, "ident  mulOp  ExpressionDecl / ident  mulOp  ident"
  define :rem, "ident  remOp  ExpressionDecl / ident  remOp  ident"

  # Operações Booleanas
  define :PredicateDecl, "equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals,     "ident notEqualsOp     ident"
  define :equals,        "ident equalsOp        ident"
  define :greater,       "ident greaterOp       ident"
  define :less,          "ident lessOp          ident"
  define :greaterEquals, "ident greaterEqualsOp ident"
  define :lessEquals,    "ident lessEqualsOp    ident"
  define :notExp,        "notOp PredicateDecl"

  # Comandos

    define :atrib, "ident atrOp value"

    define :ident, "decimal / varName"


  # Value

  define :value, "decimal / Expression"

  # Numeros

  define :decimal, "decimalP / decimalN" do
      digitis -> Enum.join(digitis)
  end

  define :decimalP, "digit+"

  define :decimalN, "subOp digit+"

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

  define :notOp, "[~]"

  # Nome de Variaveis

  #Usar letter e digit está caindo em recurão infinita
  #TODO: Mudar a regra a-zA-Z0-9 para letter,digit*
  define :varName, "letter[a-zA-Z0-9]*" do
    letter -> Enum.join(letter)
  end

  define :letter, "[a-zA-Z]"

  define :atrOp, "<space?> [:][=] <space?>" do
    x -> Enum.join(x)
  end

end
