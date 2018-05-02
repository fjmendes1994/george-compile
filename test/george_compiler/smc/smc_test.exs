defmodule SMCTest do
  @moduledoc false

  use ExUnit.Case

  @doc "testes da pilha C"
  test "Verifica pilhas" do
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, Stack.new) == {Stack.new, Stack.new, Stack.new}
  end

  test "Esvazia pilha c e para" do
    c = Stack.new 
        |> Stack.push((Tree.new(5))) 
        |> Stack.push((Tree.new(6)))
    assert elem(GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c),2) == Stack.new
  end

  test "Esvazia pilha c e verifica s" do
    c = Stack.new 
        |> Stack.push((Tree.new(5))) 
        |> Stack.push((Tree.new(6)))
    s = Stack.new
        |> Stack.push(6) 
        |> Stack.push(5)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  @doc "Testes aritiméticos"
  test "Esvazia pilha c e faz soma utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("add")) 
        |> Stack.push((Tree.new(5))) 
        |> Stack.push((Tree.new(6)))
    s = Stack.new 
        |> Stack.push(11)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Esvazia pilha c e faz subtração utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("sub")) 
        |> Stack.push((Tree.new(5))) 
        |> Stack.push((Tree.new(6)))
    s = Stack.new 
        |> Stack.push(1)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Esvazia pilha c e faz multiplicação utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("mul")) 
        |> Stack.push((Tree.new(5)))
        |> Stack.push((Tree.new(6)))
    s = Stack.new 
        |> Stack.push(30)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Esvazia pilha c e faz divisão utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("div")) 
        |> Stack.push((Tree.new(1))) 
        |> Stack.push((Tree.new(2)))
    s = Stack.new 
        |> Stack.push(2)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: 1+2
  test "Decompoe arvore em c e faz adição utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("add") 
                      |> Tree.add_leaf(1) 
                      |> Tree.add_leaf(2))
    s = Stack.new 
      |> Stack.push(3)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: 1-2
  test "Decompoe arvore em c e faz subtração utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("sub") 
                      |> Tree.add_leaf(1) 
                      |> Tree.add_leaf(2))
    s = Stack.new 
        |> Stack.push(-1)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: 1*2
  test "Decompoe arvore em c e faz multiplicação utilzando s" do
    c = Stack.new
        |> Stack.push(Tree.new("mul") 
                      |> Tree.add_leaf(1) 
                      |> Tree.add_leaf(2))
    s = Stack.new 
        |> Stack.push(2)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: 2/1
  test "Decompoe arvore em c e faz divisao utilzando s" do
    c = Stack.new 
        |> Stack.push(Tree.new("div") 
                      |> Tree.add_leaf(2) 
                      |> Tree.add_leaf(1))
    s = Stack.new 
        |> Stack.push(2)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: x+y, x=1 e y=2
  test "Decompoe arvore em c e faz adição utilzando s e m" do
    c = Stack.new 
        |> Stack.push(Tree.new("add") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
      |> Stack.push(3)
    m = %{"x" => 1, "y" => 2}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  #Expressão: x,y, x=1 e y=2
  test "Decompoe arvore em c e faz subtração utilzando s e m" do
    c = Stack.new 
        |> Stack.push(Tree.new("sub") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
        |> Stack.push(-1)
    m = %{"x" => 1, "y" => 2}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  #Expressão: x*y, x=1 e y=2
  test "Decompoe arvore em c e faz multiplicação utilzando s e m" do
    c = Stack.new
        |> Stack.push(Tree.new("mul") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
        |> Stack.push(2)
    m = %{"x" => 1, "y" => 2}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  #Expressão: x/y, x=2 e y=1
  test "Decompoe arvore em c e faz divisao utilzando s e m" do
    c = Stack.new 
        |> Stack.push(Tree.new("div") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
        |> Stack.push(2)
    m = %{"x" => 2, "y" => 1}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  #Expressão: 5 + 5 - 2
  test "Multiplas operações add e sub" do
    tree = Tree.new("sub") 
          |> Tree.add_leaf(5) 
          |> Tree.add_leaf(2)
    c = Stack.new 
        |> Stack.push(Tree.new("add") 
                      |> Tree.add_leaf(5) 
                      |> Tree.add_leaf(tree))
    s = Stack.new 
        |> Stack.push(8)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: 3 * 5 + 2
  test "Multiplas operações mult e add" do
    tree = Tree.new("mul") 
          |> Tree.add_leaf(3) 
          |> Tree.add_leaf(5)
    c = Stack.new 
        |> Stack.push(Tree.new("add") 
                      |> Tree.add_leaf(tree) 
                      |> Tree.add_leaf(2))
    s = Stack.new 
        |> Stack.push(17)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  #Expressão: 2 * 10 - 3 * 1
  test "Multiplas operações mult e sub" do
    tree_a = Tree.new("mul") 
            |> Tree.add_leaf(2) 
            |> Tree.add_leaf(10)
    tree_b = Tree.new("mul") |> Tree.add_leaf(3) |> Tree.add_leaf(1)

    c = Stack.new 
        |> Stack.push(Tree.new("sub") 
                      |> Tree.add_leaf(tree_a) 
                      |> Tree.add_leaf(tree_b))
    s = Stack.new 
        |> Stack.push(17)
    
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end



  @doc "Testes booleanos"
  test "Igualdade booleana" do
    c = Stack.new 
        |> Stack.push(Tree.new("eq") 
                      |> Tree.add_leaf(5) 
                      |> Tree.add_leaf(5))
    s = Stack.new 
        |> Stack.push(true)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Igualdade booleana com variaveis" do
    c = Stack.new 
        |> Stack.push(Tree.new("eq") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
        |> Stack.push(true)
    m = %{"x" => 5, "y" => 5}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  test "Maior que" do
    c = Stack.new 
        |> Stack.push(Tree.new("gt") 
                      |> Tree.add_leaf(6) 
                      |> Tree.add_leaf(5))
    s = Stack.new 
        |> Stack.push(true)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Maior que com variaveis" do
    c = Stack.new 
        |> Stack.push(Tree.new("gt") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
        |> Stack.push(true)
    m = %{"x" => 3, "y" => 2}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  test "Menor que" do
    c = Stack.new 
        |> Stack.push(Tree.new("lt") 
                      |> Tree.add_leaf(5) 
                      |> Tree.add_leaf(6))
    s = Stack.new 
        |> Stack.push(true)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Menor que com variaveis" do
    c = Stack.new 
        |> Stack.push(Tree.new("lt") 
                      |> Tree.add_leaf("x") 
                      |> Tree.add_leaf("y"))
    s = Stack.new 
        |> Stack.push(true)
    m = %{"x" => 1, "y" => 2}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  test "Negação booleana" do
    c = Stack.new 
        |> Stack.push(Tree.new("neg") 
                      |> Tree.add_leaf(false))
    s = Stack.new 
        |> Stack.push(true)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end

  test "Negação booleana com variavel" do
    c = Stack.new 
        |> Stack.push(Tree.new("neg") 
                      |> Tree.add_leaf("x"))
    s = Stack.new 
        |> Stack.push(true)
    m = %{"x" => false}
    assert GeorgeCompiler.SMC.evaluate(Stack.new , m, c) == {s, m, Stack.new}
  end

  @doc "Atribuição e desvios"
  test "Atribuição com árvore" do
    c = Stack.new
        |> Stack.push(Tree.new("attrib")
                      |> Tree.add_leaf("var")
                      |> Tree.add_leaf(5))
    m = %{"var" => 5}
    assert GeorgeCompiler.SMC.evaluate(Stack.new, %{}, c) == {Stack.new, m, Stack.new}
  end

  test "if com else entrando no if" do
    greater = Tree.new("gt")
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)
    sum = Tree.new("add")
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)
    sub = Tree.new("sub")
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)

    if_tree = Tree.new("if")
                |> Tree.add_leaf(greater)
                |> Tree.add_leaf(sum)
                |> Tree.add_leaf(sub)
    c = Stack.new
        |> Stack.push(if_tree)
    s = Stack.new
        |> Stack.push(4)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, %{}, c) == {s, %{}, Stack.new}
  end

  test "if com else entrando no else" do
    greater = Tree.new("lt")
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)
    sum = Tree.new("add")
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)
    sub = Tree.new("sub")
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)
    if_tree = Tree.new("if")
                |> Tree.add_leaf(greater)
                |> Tree.add_leaf(sum)
                |> Tree.add_leaf(sub)
    c = Stack.new
        |> Stack.push(if_tree)
    s = Stack.new
        |> Stack.push(0)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, %{}, c) == {s, %{}, Stack.new}
  end

  test "if sem else entrando no else" do
    greater = Tree.new("lt")
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)
    sum = Tree.new("add")
					|> Tree.add_leaf(2)
					|> Tree.add_leaf(2)
    if_tree = Tree.new("if")
							|> Tree.add_leaf(greater)
							|> Tree.add_leaf(sum)
							|> Tree.add_leaf(nil)
    c = Stack.new
        |> Stack.push(if_tree)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, %{}, c) == {Stack.new, %{}, Stack.new}
  end

	test "Sequencia" do
		sum = Tree.new("add")
					|> Tree.add_leaf(5)
					|> Tree.add_leaf(4)
		div = Tree.new("div")
					|> Tree.add_leaf(10)
					|> Tree.add_leaf(2)
		tree = Tree.new("seq")
						|> Tree.add_leaf(sum)
						|> Tree.add_leaf(div)
		c = Stack.new
				|> Stack.push(tree)
		s = Stack.new
				|> Stack.push(9)
				|> Stack.push(5)
		assert GeorgeCompiler.SMC.evaluate(Stack.new, %{}, c) == {s, %{}, Stack.new}		
  end

  test "While não executando" do
    condition = Tree.new("eq")
                |> Tree.add_leaf(4)
                |> Tree.add_leaf(3)
    sum = Tree.new

    while = Tree.new("while")
            |> Tree.add_leaf(condition)
            |> Tree.add_leaf(sum)
    c = Stack.new
        |> Stack.push(while)
    
    assert GeorgeCompiler.SMC.evaluate(Stack.new, %{}, c) == {Stack.new, %{}, Stack.new}
  end

  test "While executando" do
    condition = Tree.new("lt")
                |> Tree.add_leaf("i")
                |> Tree.add_leaf(5)
    sum = Tree.new("add")
                |> Tree.add_leaf("i")
                |> Tree.add_leaf(1)
    atrib = Tree.new("attrib")
            |> Tree.add_leaf("i")
            |> Tree.add_leaf(sum)

    while = Tree.new("while")
            |> Tree.add_leaf(condition)
            |> Tree.add_leaf(atrib)
     c = Stack.new
        |> Stack.push(while)

    assert GeorgeCompiler.SMC.evaluate(Stack.new, %{"i" => 1}, c) == {Stack.new, %{"i" => 5}, Stack.new}
  end
end