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
end
