defmodule SMCTest do
  @moduledoc false

  use ExUnit.Case

  test "Verifica pilhas" do
    GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, Stack.new) == {Stack.new, Stack.new, Stack.new}
  end

  test "Esvazia pilha c e para" do
    c = Stack.new |> Stack.push(5) |> Stack.push(6)
    GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, c) == {Stack.new, Stack.new, Stack.new}
  end

end
