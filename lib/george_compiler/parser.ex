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
  define :ifOp, "<space?> [i][f] <space?>"do
    x -> Enum.join(x)
  end
  define :elseOp, "<space?> [e][l][s][e] <space?>"do
    x -> Enum.join(x)
  end

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
  define :word, "lowcase* upcase / lowcase upcase*" do
    x -> Enum.join(x)
  end

  define :ident, "word digit* ident?" do
    x -> Enum.join(x)
  end

  # Chaves e parenteses
  define :lp, "<space?> [(] <space?>"
  define :rp, "<space?> [)] <space?>"
  define :lk, "<space?> [{] <space?>"
  define :rk, "<space?> [}] <space?>"


  # Expressoes
  define :BlockCommandDecl, "<lk> CommandDecl+ <rk> "

  @root true
  define :CommandDecl, "atrib / if / Expression"

  define :Expression, "PredicateDecl / ExpressionDecl"

  # Expressoes aritimeticas

  define :ExpressionDecl, "PredicateDecl / additiveExp / decimal / ident"

  define :additiveExp, "sum / sub / multitiveExp"

  define :multitiveExp, "mul / rem / div"

  define :sum, "(decimal / ident) sumOp ExpressionDecl"
  define :sub, "(decimal / ident) subOp ExpressionDecl"
  define :div, "(decimal / ident) divOp ExpressionDecl"
  define :mul, "(decimal / ident) mulOp ExpressionDecl"
  define :rem, "(decimal / ident) remOp ExpressionDecl"

  # Expressoes Booleanas

  define :PredicateDecl, "negExp / equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals, "(decimal / ident) notEqualsOp ExpressionDecl"
  define :equals, "(decimal / ident) equalsOp ExpressionDecl"
  define :greater, "(decimal / ident) greaterOp ExpressionDecl"
  define :less, "(decimal / ident) lessOp ExpressionDecl"
  define :greaterEquals, "(decimal / ident) greaterEqualsOp ExpressionDecl"
  define :lessEquals, "(decimal / ident) lessEqualsOp ExpressionDecl"
  define :negExp, "negOp PredicateDecl"

  # Comandos

  define :atrib, "ident assOp Expression"

  define :else, "elseOp (CommandDecl / BlockCommandDecl)"
  define :if, "ifOp <lp> PredicateDecl <rp> (CommandDecl / BlockCommandDecl) else?"



end
