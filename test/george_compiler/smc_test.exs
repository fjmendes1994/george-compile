defmodule SMCTest do
  @moduledoc false

  use ExUnit.Case

  test "Verifica pilhas" do
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, Stack.new) == {Stack.new, Stack.new, Stack.new}
  end

  test "Esvazia pilha c e para" do
    c = Stack.new |> Stack.push((Tree.new(5))) |> Stack.push((Tree.new(6)))
    assert elem(GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c),2) == Stack.new
  end

  test "Esvazia pilha c e verifica s" do
    c = Stack.new |> Stack.push((Tree.new(5))) |> Stack.push((Tree.new(6)))
    s = Stack.new |> Stack.push(6) |> Stack.push(5)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Esvazia pilha c e faz soma utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("add")) |> Stack.push((Tree.new(5))) |> Stack.push((Tree.new(6)))
    s = Stack.new |> Stack.push(11)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Esvazia pilha c e faz subtração utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("sub")) |> Stack.push((Tree.new(5))) |> Stack.push((Tree.new(6)))
    s = Stack.new |> Stack.push(1)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Esvazia pilha c e faz multiplicação utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("mult")) |> Stack.push((Tree.new(5))) |> Stack.push((Tree.new(6)))
    s = Stack.new |> Stack.push(30)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Esvazia pilha c e faz divisão utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("div")) |> Stack.push((Tree.new(1))) |> Stack.push((Tree.new(2)))
    s = Stack.new |> Stack.push(2)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Decompoe arvore em c e faz adição utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("add") |> Tree.add_leaf(1) |> Tree.add_leaf(2))
    s = Stack.new |> Stack.push(3)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Decompoe arvore em c e faz subtração utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("sub") |> Tree.add_leaf(1) |> Tree.add_leaf(2))
    s = Stack.new |> Stack.push(-1)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Decompoe arvore em c e faz multiplicação utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("mult") |> Tree.add_leaf(1) |> Tree.add_leaf(2))
    s = Stack.new |> Stack.push(2)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end

  test "Decompoe arvore em c e faz divisao utilzando s" do
    c = Stack.new |> Stack.push(Tree.new("div") |> Tree.add_leaf(2) |> Tree.add_leaf(1))
    s = Stack.new |> Stack.push(2)
    assert GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {s,Stack.new,Stack.new}
  end
end
