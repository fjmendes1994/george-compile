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
  define :orOP, "<space?> <'or'> <space?>"
  define :andOP, "<space?> <'and'> <space?>"

  # Operadores de Comandos

  define :assOp, "<space?> [:][=] <space?>" do
    x -> Enum.join(x)
  end
  define :seqOp, "<space?> [;] <space?>"
  define :comOp, "<space?> [,] <space?>"
  define :iniOp, "<space?> [=] <space?>"
  define :ifOp, "<space?><'if'><space?>"
  define :elseOp, "<space?><'else'><space?>"
  define :whileOp, "<space?><'while'><space?>" 
  define :printOp, "<space?><'exit'><space?>"
  define :exitOp, "<space?><'exit'><space?>"
  define :doOp, "<space?> <'do'> <space?>"
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
    [x,_,y] ->  Tree.new("add") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :sub, "(decimal / ident) subOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("sub") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :div, "(decimal / ident) divOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("div") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :mul, "(decimal / ident) mulOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("mul") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :rem, "(decimal / ident) remOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("rem") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  # Expressoes Booleanas

  define :PredicateDecl, "and / or / boolExp"

  define :boolExp, "<lp> boolExp <rp>/ negExp / equals / greaterEquals / lessEquals / greater / less / notEquals" do
    [x] -> x
    x -> x
  end

  define :notEquals, "(decimal / ident) notEqualsOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("neq") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :equals, "(decimal / ident) equalsOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("eq") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :greater, "(decimal / ident) greaterOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("gt") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :less, "(decimal / ident) lessOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("lt") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :greaterEquals, "(decimal / ident) greaterEqualsOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("ge") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :lessEquals, "(decimal / ident) lessEqualsOp ExpressionDecl" do
    [x,_,y] ->  Tree.new("le") |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :negExp, "negOp PredicateDecl" do
    [_, x] ->  Tree.new("neg") |> Tree.add_leaf(x)
  end

  define :or, "boolExp orOP PredicateDecl" do
    [x, predicate] -> Tree.new("or") |> Tree.add_leaf(x) |> Tree.add_leaf(predicate)
  end

  define :and, "boolExp andOP PredicateDecl" do
    [x,[], predicate] -> Tree.new("and") |> Tree.add_leaf(x) |> Tree.add_leaf(predicate)
  end

  # Comandos
  define :BlockCommandDecl, "<lk> CommandDecl+ <rk> "

  @root true
  define :CommandDecl, "choice / seq / cmd"

  define :cmd, "atrib / if / while / print / exit / call / Expression"

  define :atrib, "ident assOp Expression" do
    [var , _, exp] -> Tree.new("atrib") |> Tree.add_leaf(var) |> Tree.add_leaf(exp)
  end

  define :else, "elseOp (CommandDecl / BlockCommandDecl)" do
    [_, block] -> block
  end

  define :if, "ifOp <lp> PredicateDecl <rp> (CommandDecl / BlockCommandDecl) else?" do
    [_, predicate, [[block]], [[else_block]]] ->  Tree.new("if") |> Tree.add_leaf(predicate) |> Tree.add_leaf(block) |> Tree.add_leaf(else_block)
    [_, predicate, [[block]], nil_value] ->  Tree.new("if") |> Tree.add_leaf(predicate) |> Tree.add_leaf(block) |> Tree.add_leaf(nil_value)
  end

  define :while, "<whileOp> <lp?> PredicateDecl <rp?> <doOp> BlockCommandDecl" do
    [predicate, [[block]]] -> Tree.new("while") |> Tree.add_leaf(predicate) |> Tree.add_leaf(block)
  end

  define :print, "printOp <lp> Expression <rp>"

  define :exit, "exitOp <lp> Expression <rp>"

  define :call, "ident <lp> Expression* <rp> "

  define :seq, "cmd seqOp CommandDecl" do
    [cmd, _, commandDecl] -> Tree.new("seq") |> Tree.add_leaf(cmd) |> Tree.add_leaf(commandDecl)
  end

  define :choice, "cmd choOp CommandDecl"
end
