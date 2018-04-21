defmodule SMCTest do
  @moduledoc false

  use ExUnit.Case

  test "Faz nada" do
    GeorgeCompiler.SMC.evaluate(Stack.new, Stack.new, Stack.new) == {Stack.new, Stack.new, Stack.new}
  end

end
