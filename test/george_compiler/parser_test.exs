defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case

  test "soma simples" do
    assert GeorgeCompiler.Parser.parse("10 + -20 + 30") == {:ok, ["10", ["20", "30"]]}
  end

  test "subtracao simples" do
    assert GeorgeCompiler.Parser.parse("10 + -20 - 30") == {:ok, ["10", ["20", "30"]]}
  end


  test "divisao simples" do
    assert GeorgeCompiler.Parser.parse("10 + -20 - 30 / 40") == {:ok, ["10", ["20", ["30", "40"]]]}
  end

  test "multiplicacao simples" do
    assert GeorgeCompiler.Parser.parse("10 + -20 - 30 / 40 * 50") == {:ok, ["10", ["20", ["30", ["40", "50"]]]]}
  end

  test "resto simples" do
    assert GeorgeCompiler.Parser.parse("10 + -20 - 30 / 40 * 50 % 60") == {:ok, ["10", ["20", ["30", ["40", ["50", "60"]]]]]}
  end

  test "equals siples" do
    assert GeorgeCompiler.Parser.parse("10==20") == {:ok, ["10", "20"]}
  end




end
