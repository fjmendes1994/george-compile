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
  define :orOP, "<space?> [o][r] <space?>"
  define :andOP, "<space?> [a][n][d] <space?>"

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
  define :whileOp, "<space?> [w][h][i][l][e] <space?>"do
    x -> Enum.join(x)
  end
  define :printOp, "<space?> [p][r][i][n][t] <space?>"do
    x -> Enum.join(x)
  end
  define :exitOp, "<space?> [e][x][i][t] <space?>"do
    x -> Enum.join(x)
  end
  define :seqOp, "<space?> [;] <space?>" do
    [x] -> x
  end
  define :choOp, "<space?> [|] <space?>" do
    [x] -> x
  end

  # Numeros

  define :digit, "[0-9]"
  define :decimalP, "digit+"
  define :decimalN, "subOp digit+"
  define :decimal, "decimalP / decimalN" do
    digitis -> Enum.join(digitis) |> String.to_integer
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

  define :Expression, "PredicateDecl / ExpressionDecl"

  # Expressoes aritimeticas

  define :ExpressionDecl, "PredicateDecl / additiveExp / decimal / ident"

  define :additiveExp, "sum / sub / multitiveExp"

  define :multitiveExp, "mul / rem / div"

  define :sum, "(decimal / ident) sumOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("add") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :sub, "(decimal / ident) subOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("sub") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :div, "(decimal / ident) divOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("div") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :mul, "(decimal / ident) mulOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("mul") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :rem, "(decimal / ident) remOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("rem") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  # Expressoes Booleanas

  define :PredicateDecl, "and / or / boolExp"

  define :boolExp, "negExp / equals / greaterEquals / lessEquals / greater / less / notEquals"

  define :notEquals, "(decimal / ident) notEqualsOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("neq") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :equals, "(decimal / ident) equalsOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("eq") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :greater, "(decimal / ident) greaterOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("gt") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :less, "(decimal / ident) lessOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("lt") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :greaterEquals, "(decimal / ident) greaterEqualsOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("ge") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :lessEquals, "(decimal / ident) lessEqualsOp ExpressionDecl" do
    [x,_,y] -> IO.inspect Tree.new("le") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :negExp, "negOp PredicateDecl" do
    [x,_,y] -> IO.inspect Tree.new("neg") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :or, "boolExp orOP PredicateDecl"
  define :and, "boolExp andOP PredicateDecl"

  # Comandos
  define :BlockCommandDecl, "<lk> CommandDecl+ <rk> "

  @root true
  define :CommandDecl, "choice / seq / cmd"

  define :cmd, "atrib / if / while / print / exit / call / Expression"

  define :atrib, "ident assOp Expression"

  define :else, "elseOp (CommandDecl / BlockCommandDecl)"
  define :if, "ifOp <lp> PredicateDecl <rp> (CommandDecl / BlockCommandDecl) else?"

  define :while, "whileOp <lp> PredicateDecl <rp> BlockCommandDecl"

  define :print, "printOp <lp> Expression <rp>"

  define :exit, "exitOp <lp> Expression <rp>"

  define :call, "ident <lp> Expression* <rp> "

  define :seq, "cmd seqOp CommandDecl"

  define :choice, "cmd choOp CommandDecl"





end
