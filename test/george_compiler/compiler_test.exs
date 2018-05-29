defmodule CompilerTest do
  @moduledoc false

  alias GeorgeCompiler.SMC, as: SMC

  use ExUnit.Case

  test "Esvazia pilha c e para" do
    smc = SMC.new
        |> SMC.add_control(5)
        |> SMC.add_control(6)
    assert GeorgeCompiler.Compiler.evaluate(smc).c == Stack.new
  end

  test "Esvazia pilha c e verifica s" do
    smc = SMC.new
        |> SMC.add_control(6)
        |> SMC.add_control(5)

    result = SMC.new
             |> SMC.add_value(5)
             |> SMC.add_value(6)
    
    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  @doc "Testes aritiméticos"
  test "Esvazia pilha c e faz soma utilzando s" do
    smc = SMC.new
        |> SMC.add_control(:add)
        |> SMC.add_control(5)
        |> SMC.add_control(6)
    
    result = SMC.new
          |> SMC.add_value(11)
    
    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Esvazia pilha c e faz subtração utilzando s" do
    smc = SMC.new
        |> SMC.add_control(:sub)
        |> SMC.add_control(5)
        |> SMC.add_control(6)

    result = SMC.new
            |> SMC.add_value(1)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Esvazia pilha c e faz multiplicação utilzando s" do
    smc = SMC.new
        |> SMC.add_control(:mul)
        |> SMC.add_control(5)
        |> SMC.add_control(6)

    result = SMC.new
            |> SMC.add_value(30)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Esvazia pilha c e faz divisão utilzando s" do
    smc = SMC.new
        |> SMC.add_control(:div)
        |> SMC.add_control(1)
        |> SMC.add_control(2)

    result = SMC.new
            |> SMC.add_value(2)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: 1+2
  test "Decompoe arvore em c e faz adição utilzando s" do
    tree = Tree.new(:add)
          |> Tree.add_leaf(1)
          |> Tree.add_leaf(2)

    smc = SMC.new
          |> SMC.add_control(tree)

    result = SMC.new
            |> SMC.add_value(3)
    
    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: 1-2
  test "Decompoe arvore em c e faz subtração utilzando s" do
    tree = Tree.new(:sub)
          |> Tree.add_leaf(1)
          |> Tree.add_leaf(2)

    smc = SMC.new
          |> SMC.add_control(tree)

    result = SMC.new
            |> SMC.add_value(-1)

    assert GeorgeCompiler.Compiler.evaluate(smc) ==result
  end

  #Expressão: 1*2
  test "Decompoe arvore em c e faz multiplicação utilzando s" do
    tree = Tree.new(:mul)
          |> Tree.add_leaf(1)
          |> Tree.add_leaf(2)

    smc = SMC.new
          |> SMC.add_control(tree)

    result = SMC.new
            |> SMC.add_value(2)

    assert GeorgeCompiler.Compiler.evaluate(smc) ==result
  end

  #Expressão: 2/1
  test "Decompoe arvore em c e faz divisao utilzando s" do
    tree = Tree.new(:div)
          |> Tree.add_leaf(2)
          |> Tree.add_leaf(1)

    smc = SMC.new
          |> SMC.add_control(tree)

    result = SMC.new
            |> SMC.add_value(2)
            
    assert GeorgeCompiler.Compiler.evaluate(smc) ==result
  end

  #Expressão: x+y, x=1 e y=2
  test "Decompoe arvore em c e faz adição utilzando s e m" do
    tree = Tree.new(:add)
          |> Tree.add_leaf("x")
          |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree)
          |> SMC.add_store("x", 1)
          |> SMC.add_store("y", 2)

    result = SMC.new
             |> SMC.add_value(3)
             |> SMC.add_store("x", 1)
             |> SMC.add_store("y", 2)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: x,y, x=1 e y=2
  test "Decompoe arvore em c e faz subtração utilzando s e m" do
    tree = Tree.new(:sub)
          |> Tree.add_leaf("x")
          |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree)
          |> SMC.add_store("x", 1)
          |> SMC.add_store("y", 2)

    result = SMC.new
             |> SMC.add_value(-1)
             |> SMC.add_store("x", 1)
             |> SMC.add_store("y", 2)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: x*y, x=1 e y=2
  test "Decompoe arvore em c e faz multiplicação utilzando s e m" do
    tree = Tree.new(:mul)
          |> Tree.add_leaf("x")
          |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree)
          |> SMC.add_store("x", 1)
          |> SMC.add_store("y", 2)

    result = SMC.new
             |> SMC.add_value(2)
             |> SMC.add_store("x", 1)
             |> SMC.add_store("y", 2)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: x/y, x=2 e y=1
  test "Decompoe arvore em c e faz divisao utilzando s e m" do
    tree = Tree.new(:div)
          |> Tree.add_leaf("x")
          |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree)
          |> SMC.add_store("x", 2)
          |> SMC.add_store("y", 1)

    result = SMC.new
             |> SMC.add_value(2)
             |> SMC.add_store("x", 2)
             |> SMC.add_store("y", 1)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: 3 + 4 - 2
  test "Multiplas operações add e sub" do
    tree_sub = Tree.new(:sub)
          |> Tree.add_leaf(4)
          |> Tree.add_leaf(2)
    
    tree_add = Tree.new(:add)
          |> Tree.add_leaf(3)
          |> Tree.add_leaf(tree_sub)

    smc = SMC.new
          |> SMC.add_control(tree_add)

    result = SMC.new
             |> SMC.add_value(5)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  #Expressão: 3 * 5 + 2
  test "Multiplas operações mult e add" do
    tree_mul = Tree.new(:mul)
          |> Tree.add_leaf(3)
          |> Tree.add_leaf(5)

    tree_add = Tree.new(:add)
          |> Tree.add_leaf(tree_mul)
          |> Tree.add_leaf(2)

    smc = SMC.new
          |> SMC.add_control(tree_add)
  
    result = SMC.new
             |> SMC.add_value(17)

    assert GeorgeCompiler.Compiler.evaluate(smc) ==result
  end

  #Expressão: 2 * 10 - 3 * 1
  test "Multiplas operações mult e sub" do
    tree_a = Tree.new(:mul)
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(10)

    tree_b = Tree.new(:mul) 
            |> Tree.add_leaf(3) 
            |> Tree.add_leaf(1)
    
    tree_sub = Tree.new(:sub)
              |> Tree.add_leaf(tree_a)
              |> Tree.add_leaf(tree_b)
    
    smc = SMC.new
          |> SMC.add_control(tree_sub)  

    result = SMC.new
          |> SMC.add_value(17)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end



  @doc "Testes booleanos"
  test "Igualdade booleana" do
    tree_eq = Tree.new(:eq)
              |> Tree.add_leaf(5)
              |> Tree.add_leaf(5)

    smc = SMC.new
          |> SMC.add_control(tree_eq)

    result = SMC.new
          |> SMC.add_value(true)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Igualdade booleana com variaveis" do
    tree_eq = Tree.new(:eq)
              |> Tree.add_leaf("x")
              |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree_eq)
          |> SMC.add_store("x", 5)
          |> SMC.add_store("y", 5)

    result = SMC.new
            |> SMC.add_value(true)
            |> SMC.add_store("x", 5)
            |> SMC.add_store("y", 5)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Maior que" do
    tree_gt = Tree.new(:gt)
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)

    smc = SMC.new
          |> SMC.add_control(tree_gt)

    result = SMC.new
          |> SMC.add_value(true)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Maior que com variaveis" do
    tree_gt = Tree.new(:gt)
              |> Tree.add_leaf("x")
              |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree_gt)
          |> SMC.add_store("x", 6)
          |> SMC.add_store("y", 5)

    result = SMC.new
            |> SMC.add_value(true)
            |> SMC.add_store("x", 6)
            |> SMC.add_store("y", 5)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Menor que" do
    tree_lt = Tree.new(:lt)
              |> Tree.add_leaf(5)
              |> Tree.add_leaf(6)

    smc = SMC.new
          |> SMC.add_control(tree_lt)

    result = SMC.new
             |> SMC.add_value(true)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Menor que com variaveis" do
   tree_lt = Tree.new(:lt)
              |> Tree.add_leaf("x")
              |> Tree.add_leaf("y")

    smc = SMC.new
          |> SMC.add_control(tree_lt)
          |> SMC.add_store("x", 5)
          |> SMC.add_store("y", 6)

    result = SMC.new
            |> SMC.add_value(true)
            |> SMC.add_store("x", 5)
            |> SMC.add_store("y", 6)
            
    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Negação booleana" do
    tree_neg = Tree.new(:neg)
               |> Tree.add_leaf(false)

    smc = SMC.new
          |> SMC.add_control(tree_neg)
    
    result = SMC.new
            |> SMC.add_value(true)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "Negação booleana com variavel" do
    tree_neg = Tree.new(:neg)
               |> Tree.add_leaf("x")

    smc = SMC.new
          |> SMC.add_control(tree_neg)
          |> SMC.add_store("x", false)
         
    result = SMC.new
            |> SMC.add_value(true)
            |> SMC.add_store("x", false)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  @doc "Atribuição e desvios"
  test "Atribuição com árvore" do
    tree_atrib = Tree.new(:attrib)
                |> Tree.add_leaf("var")
                |> Tree.add_leaf(5)
    smc = SMC.new
          |> SMC.add_control(tree_atrib)
    
    result = SMC.new
            |> SMC.add_store("var", 5)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "if com else entrando no if" do
    greater = Tree.new(:gt)
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)
    sum = Tree.new(:add)
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)
    sub = Tree.new(:sub)
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)

    if_tree = Tree.new(:if)
                |> Tree.add_leaf(greater)
                |> Tree.add_leaf(sum)
                |> Tree.add_leaf(sub)
    
    smc = SMC.new
          |> SMC.add_control(if_tree)

    result = SMC.new
            |> SMC.add_value(4)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "if com else entrando no else" do
    greater = Tree.new(:lt)
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)

    sum = Tree.new(:add)
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)

    sub = Tree.new(:sub)
            |> Tree.add_leaf(2)
            |> Tree.add_leaf(2)

    if_tree = Tree.new(:if)
                |> Tree.add_leaf(greater)
                |> Tree.add_leaf(sum)
                |> Tree.add_leaf(sub)

    smc = SMC.new
          |> SMC.add_control(if_tree)
      
    result = SMC.new
            |> SMC.add_value(0)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "if sem else entrando no else" do
    greater = Tree.new(:lt)
              |> Tree.add_leaf(6)
              |> Tree.add_leaf(5)
    sum = Tree.new(:add)
          |> Tree.add_leaf(2)
          |> Tree.add_leaf(2)
    if_tree = Tree.new(:if)
              |> Tree.add_leaf(greater)
              |> Tree.add_leaf(sum)
              |> Tree.add_leaf(nil)

    smc = SMC.new
          |> SMC.add_control(if_tree)

    assert GeorgeCompiler.Compiler.evaluate(smc) == SMC.new
  end

  test "Sequencia" do
    sum = Tree.new(:add)
          |> Tree.add_leaf(5)
          |> Tree.add_leaf(4)

    div = Tree.new(:div)
          |> Tree.add_leaf(10)
          |> Tree.add_leaf(2)

    tree = Tree.new(:seq)
            |> Tree.add_leaf(sum)
            |> Tree.add_leaf(div)

    smc = SMC.new
          |> SMC.add_control(tree)

    result = SMC.new
            |> SMC.add_value(9)
            |> SMC.add_value(5)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end

  test "While não executando" do
    condition = Tree.new(:eq)
                |> Tree.add_leaf(4)
                |> Tree.add_leaf(3)

    sum = Tree.new

    while = Tree.new(:while)
            |> Tree.add_leaf(condition)
            |> Tree.add_leaf(sum)

    smc = SMC.new
          |> SMC.add_control(while)

    assert GeorgeCompiler.Compiler.evaluate(smc) == SMC.new
  end

  test "While executando" do
    condition = Tree.new(:lt)
                |> Tree.add_leaf("i")
                |> Tree.add_leaf(5)
    sum = Tree.new(:add)
                |> Tree.add_leaf("i")
                |> Tree.add_leaf(1)
    atrib = Tree.new(:attrib)
            |> Tree.add_leaf("i")
            |> Tree.add_leaf(sum)

    while = Tree.new(:while)
            |> Tree.add_leaf(condition)
            |> Tree.add_leaf(atrib)

    smc = SMC.new
          |> SMC.add_control(while)
          |> SMC.add_store("i", 1)

    result = SMC.new
            |> SMC.add_store("i", 5)

    assert GeorgeCompiler.Compiler.evaluate(smc) == result
  end
end
