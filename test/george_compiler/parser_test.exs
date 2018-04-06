defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case

  test "soma simples" do
    assert GeorgeCompiler.Parser.parse("11 + 20 + 30") == {:ok, ["11", ["20", "30"]]}
  end

  test "subtracao simples" do
    assert GeorgeCompiler.Parser.parse("11 - 20 - -30") == {:ok, ["11", ["20", "30"]]}
  end

  test "operacoes com numeros negativos" do
    assert GeorgeCompiler.Parser.parse("-11 - 20 + -30") == {:ok, ["11", ["20", "30"]]}
  end

  test "divisao simples" do
    assert GeorgeCompiler.Parser.parse("-11 / 20 + -30") == {:ok, ["11", ["20", "30"]]}
  end

  test "multiplicacao simples" do
    assert GeorgeCompiler.Parser.parse("-11 / 20 * -30") == {:ok, ["11", ["20", "30"]]}
  end


end
