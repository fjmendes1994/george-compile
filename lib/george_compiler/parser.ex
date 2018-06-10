defmodule GeorgeCompiler.Parser do

  use Neotomex.ExGrammar

  # Espaços

  define :space, "[ \\r\\n\\s\\t]*"

  # Operadores Aritmeticos

  define :sumOp, "<space?> '+' <space?>"
  define :subOp, "<space?> '-' <space?>"
  define :mulOp, "<space?> '*' <space?>"
  define :divOp, "<space?> '/' <space?>"
  define :remOp, "<space?> '%' <space?>"

  # Operadores Booleanos

  define :equalsOp, "<space?> '==' <space?>"
  define :notEqualsOp, "<space?> '!=' <space?>"
  define :greaterOp, "<space?> '>' <space?>"
  define :greaterEqualsOp, "<space?> '>=' <space?>"
  define :lessOp, "<space?> '<' <space?>"
  define :lessEqualsOp, "<space?> '<=' <space?>"
  define :negOp, "'~'"
  define :orOP, "<space?> 'or' <space?>"
  define :andOP, "<space?> 'and' <space?>"

  # Operadores de Comandos

  define :assOp, "<space?> ':=' <space?>"
  define :seqOp, "<space?> ';' <space?>"
  define :comOp, "<space?> ',' <space?>"
  define :iniOp, "<space?> '=' <space?>"
  define :ifOp, "<space?> 'if' <space?>"
  define :elseOp, "<space?> 'else' <space?>"
  define :whileOp, "<space?> 'while' <space?>"
  define :doOP, "<space?> 'do' <space?>"
  define :printOp, "<space?> 'print' <space?>"
  define :exitOp, "<space?> 'exit' <space?>"
  define :choOp, "<space?> '|' <space?>"

  # Operadores de Declaração

  define :declVarOp, "<space?> 'var' <space?>"
  define :declConstOp, "<space?> 'const' <space?>"



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
  define :lp, "<space?> '(' <space?>"
  define :rp, "<space?> ')' <space?>"
  define :lk, "<space?> '{' <space?>"
  define :rk, "<space?> '}' <space?>"


  # Expressoes
  define :Expression, "PredicateDecl / ExpressionDecl"

  # Expressoes aritmeticas
  define :PriorityExpressionDecl, "<lp> ExpressionDecl <rp>" do
    [exp] -> exp
  end

  define :ExpressionDecl, "additiveExp"

  define :additiveExp, "sum / sub / multitiveExp"

  define :multitiveExp, "mul / rem / div / primary"

  define :primary, "decimal / ident"

  define :sum, "multitiveExp <sumOp> additiveExp" do
    [x,y] ->  Tree.new(:add) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :sub, "multitiveExp <subOp> additiveExp" do
    [x,y] ->  Tree.new(:sub) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :div, "primary <divOp> multitiveExp" do
    [x,y] ->  Tree.new(:div) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :mul, "primary <mulOp> multitiveExp" do
    [x,y] ->  Tree.new(:mul) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  define :rem, "primary <remOp> multitiveExp" do
    [x,y] ->  Tree.new(:rem) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end

  # Expressoes Booleanas
  define :PriorityPredicateDecl, "<lp> PredicateDecl <rp>" do
    [exp] -> exp
  end

  define :PredicateDecl, "PriorityPredicateDecl / and / or / boolExp"

  define :boolExp, "negExp / equals / greaterEquals / lessEquals / greater / less / notEquals / ExpressionDecl"

  define :notEquals, "(decimal / ident) <notEqualsOp> PredicateDecl" do
    [x,y] ->  Tree.new(:neq) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :equals, "(decimal / ident) <equalsOp> PredicateDecl" do
    [x,y] ->  Tree.new(:eq) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :greater, "(decimal / ident) <greaterOp> PredicateDecl" do
    [x,y] ->  Tree.new(:gt) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :less, "(decimal / ident) <lessOp> PredicateDecl" do
    [x,y] ->  Tree.new(:lt) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :greaterEquals, "(decimal / ident) <greaterEqualsOp> PredicateDecl" do
    [x,y] ->  Tree.new(:ge) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :lessEquals, "(decimal / ident) <lessEqualsOp> PredicateDecl" do
    [x,y] ->  Tree.new(:le) |> Tree.add_leaf(x) |> Tree.add_leaf(y)
  end
  define :negExp, "<negOp> PredicateDecl" do
    [x] ->  Tree.new(:neg) |> Tree.add_leaf(x)
  end

  define :or, "boolExp <orOP> PredicateDecl" do
    [x, predicate] -> Tree.new(:or) |> Tree.add_leaf(x) |> Tree.add_leaf(predicate)
  end

  define :and, "boolExp <andOP> PredicateDecl" do
    [x, predicate] -> Tree.new(:and) |> Tree.add_leaf(x) |> Tree.add_leaf(predicate)
  end

  # Comandos
  @root true
  define :BlockCommandDecl, "<lk> declSeq? CommandDecl+ <rk> " do
    [nil, [cmd]] -> cmd
    [decls,[cmd]] -> Tree.new(:blk) |> Tree.add_leaf(Tree.new(:decl) |> Tree.add_leaf(decls) ) |> Tree.add_leaf(cmd)
  end

  define :CommandDecl, "choice / seq / cmd"

  define :cmd, "attrib / if / while / print / exit / call"

  define :attrib, "ident <assOp> Expression" do
    [var , exp] -> Tree.new(:attrib) |> Tree.add_leaf(var) |> Tree.add_leaf(exp)
  end

  define :else, "<elseOp> (CommandDecl / BlockCommandDecl)" do
    [block] -> block
  end

  define :if, "<ifOp> PredicateDecl (CommandDecl / BlockCommandDecl) else?" do
    [predicate, block, nil] ->  Tree.new(:if) |> Tree.add_leaf(predicate) |> Tree.add_leaf(block)
    [predicate, block, else_block] ->  Tree.new(:if) |> Tree.add_leaf(predicate) |> Tree.add_leaf(block) |> Tree.add_leaf(else_block)

  end

  define :while, "<whileOp> PredicateDecl <doOP> BlockCommandDecl" do
    [predicate, [cmd]] -> Tree.new(:while) |> Tree.add_leaf(predicate) |> Tree.add_leaf(cmd)
    [predicate, block] -> Tree.new(:while) |> Tree.add_leaf(predicate) |> Tree.add_leaf(block)
  end

  define :print, "printOp <lp> Expression <rp>"

  define :exit, "exitOp <lp> Expression <rp>"

  define :call, "ident <lp> Expression* <rp> "

  define :seq, "cmd <seqOp> CommandDecl" do
    [cmd, commandDecl] -> Tree.new(:seq) |> Tree.add_leaf(cmd) |> Tree.add_leaf(commandDecl)
  end

  define :choice, "cmd choOp CommandDecl"


  define :declSeq, "decl <seqOp> declSeq?" do
    [decl, nil] -> decl
    [decl, declSeq] -> decl ++ declSeq


  end

  define :decl, "VariablesDecls / ConstantsDecls"

  define :VariablesDecls, "<declVarOp> iniVarSeq"

  define :ConstantsDecls, "<declConstOp> iniConstSeq"

  define :iniVarSeq, "iniVar (<comOp> iniVarSeq)?" do
    [iniVar, nil] -> iniVar
    [iniVar, iniVarSeq] when not is_list(iniVar) -> [iniVar] ++ iniVarSeq
    [iniVar, iniVarSeq] -> iniVar ++ iniVarSeq
  end

  define :iniVar, "ident <iniOp> Expression" do
	   [ident, exp] -> Tree.new(:ref) |> Tree.add_leaf(ident) |> Tree.add_leaf(exp)
  end


  define :iniConstSeq, "iniConst (<comOp> iniConstSeq)?" do
    [iniConst, nil] -> iniConst
    [iniConst, iniConstSeq] when not is_list(iniConst)-> [iniConst] ++ iniConstSeq
	  [iniConst, iniConstSeq] -> iniConst ++ iniConstSeq

  end

  define :iniConst, "ident <iniOp> Expression" do
	   [ident, exp] -> Tree.new(:cns) |> Tree.add_leaf(ident) |> Tree.add_leaf(exp)
  end





end
