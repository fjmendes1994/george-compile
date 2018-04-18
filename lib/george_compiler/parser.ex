defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

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
  define :negOp, "[~]"

  # Operadores de Comandos

  define :assOp, "<space?> [:][=] <space?>" do
    x -> Enum.join(x)
  end
  define :seqOp, "<space?> [;] <space?>"
  define :comOp, "<space?> [,] <space?>"
  define :iniOp, "<space?> [=] <space?>"

  # Numeros

  define :digit, "[0-9]"
  define :decimalP, "digit+"
  define :decimalN, "subOp digit+"
  define :decimal, "decimalP / decimalN" do
    digitis -> Enum.join(digitis)
  end

  # Nome de Variaveis

  define :letter, "[a-zA-Z]"
  define :lowcase, "[a-z]+"
  define :upcase, "[A-Z]+"
  define :word, "lowcase* upcase / lowcase upcase*"
  define :ident, "word digit*"


  # Expressoes
  @root true
  define :CommandDecl, "Expression"

  define :Expression, "PredicateDecl / ExpressionDecl"

  # Expressoes aritimeticas

  define :ExpressionDecl, "PredicateDecl / additiveExp / decimal / ident"

  define :additiveExp, "sum / sub / multitiveExp"

  define :multitiveExp, "mul / rem / div"

  define :sum, "decimal sumOp ExpressionDecl / ident sumOp ExpressionDecl "
  define :sub, "decimal subOp ExpressionDecl / ident subOp ExpressionDecl "
  define :div, "decimal divOp ExpressionDecl / ident divOp ExpressionDecl "
  define :mul, "decimal mulOp ExpressionDecl / ident mulOp ExpressionDecl "
  define :rem, "decimal remOp ExpressionDecl / ident remOp ExpressionDecl "

  # Expressoes Booleanas

  define :PredicateDecl, "negExp / equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals, "decimal notEqualsOp ExpressionDecl / ident notEqualsOp ExpressionDecl "
  define :equals, "decimal equalsOp ExpressionDecl / ident equalsOp ExpressionDecl "
  define :greater, "decimal greaterOp ExpressionDecl / ident greaterOp ExpressionDecl "
  define :less, "decimal lessOp ExpressionDecl / ident lessOp ExpressionDecl "
  define :greaterEquals, "decimal greaterEqualsOp ExpressionDecl / ident greaterEqualsOp ExpressionDecl "
  define :lessEquals, "decimal lessEqualsOp ExpressionDecl / ident lessEqualsOp ExpressionDecl "
  define :negExp, "negOp PredicateDecl"

end
