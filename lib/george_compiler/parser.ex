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

  define :Expression, "ExpressionDecl"

  # Expressoes aritimeticas

  define :ExpressionDecl, "additiveExp / PredicateDecl"

  define :additiveExp, "sum / sub / multitiveExp"

  define :multitiveExp, "mul / rem / div"

  define :sum, "decimal sumOp ExpressionDecl / ident sumOp ExpressionDecl / decimal sumOp decimal / ident sumOp ident"
  define :sub, "decimal subOp ExpressionDecl / ident subOp ExpressionDecl / decimal subOp decimal / ident subOp ident"
  define :div, "decimal divOp ExpressionDecl / ident divOp ExpressionDecl / decimal divOp decimal / ident divOp ident"
  define :mul, "decimal mulOp ExpressionDecl / ident mulOp ExpressionDecl / decimal mulOp decimal / ident mulOp ident"
  define :rem, "decimal remOp ExpressionDecl / ident remOp ExpressionDecl / decimal remOp decimal / ident remOp ident"

  # Expressoes Booleanas

  define :PredicateDecl, "negExp / equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals, "decimal notEqualsOp ExpressionDecl / ident notEqualsOp ExpressionDecl / decimal notEqualsOp decimal / ident notEqualsOp ident"
  define :equals, "decimal equalsOp ExpressionDecl / ident equalsOp ExpressionDecl / decimal equalsOp decimal / ident equalsOp ident"
  define :greater, "decimal greaterOp ExpressionDecl / ident greaterOp ExpressionDecl / decimal greaterOp decimal / ident greaterOp ident"
  define :less, "decimal lessOp ExpressionDecl / ident lessOp ExpressionDecl / decimal lessOp decimal / ident lessOp ident"
  define :greaterEquals, "decimal greaterEqualsOp ExpressionDecl / ident greaterEqualsOp ExpressionDecl / decimal greaterEqualsOp decimal / ident greaterEqualsOp ident"
  define :lessEquals, "decimal lessEqualsOp ExpressionDecl / ident lessEqualsOp ExpressionDecl / decimal lessEqualsOp decimal / ident lessEqualsOp ident"
  define :negExp, "negOp PredicateDecl"

end
