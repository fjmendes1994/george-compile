defmodule SMCTest do
  @moduledoc false

  use ExUnit.Case

  # Este teste está quebrando o parser
  #test "parser para pilha de controle(C) com vazio" do
  #  assert GeorgeCompiler.Parser.parse("") |> GeorgeCompiler.eval == %Stack{elements: ["5"]}
  #end
#
#  test "parser para pilha de controle(C) com 1 valor" do
#    assert GeorgeCompiler.Parser.parse("5") |> GeorgeCompiler.SMC.eval == %Stack{elements: ["5"]}
#  end
#
#  test "parser para pilha de controle(C) com 2 operandos" do
#    assert GeorgeCompiler.Parser.parse("3+2") |> GeorgeCompiler.SMC.eval == %Stack{elements: ["3","2"]}
#  end
#
#  test "parser para pilha de controle(C) com 3 operandos" do
#    assert GeorgeCompiler.Parser.parse("5+7*2") |> GeorgeCompiler.SMC.eval == %Stack{elements: ["5","7","2"]}
#  end
end
