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
        |> Stack.push(Tree.new("mult")) 
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

  #Expressão: 182
  test "Decompoe arvore em c e faz multiplicação utilzando s" do
    c = Stack.new
        |> Stack.push(Tree.new("mult") 
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
    tree = Tree.new("mult") 
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
    tree_a = Tree.new("mult") 
            |> Tree.add_leaf(2) 
            |> Tree.add_leaf(10)
    tree_b = Tree.new("mult") |> Tree.add_leaf(3) |> Tree.add_leaf(1)

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

  test "Maior que" do
    c = Stack.new 
        |> Stack.push(Tree.new("gt") 
                      |> Tree.add_leaf(6) 
                      |> Tree.add_leaf(5))
    s = Stack.new 
        |> Stack.push(true)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
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

  test "Negação booleana" do
    c = Stack.new 
        |> Stack.push(Tree.new("not") 
                      |> Tree.add_leaf(false))
    s = Stack.new 
        |> Stack.push(true)
    assert GeorgeCompiler.SMC.evaluate(Stack.new , %{}, c) == {s, %{}, Stack.new}
  end
end