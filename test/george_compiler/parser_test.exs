defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case

  test "soma simples" do
    assert GeorgeCompiler.Parser.parse("10 + -20 + 30") == {:ok, ["10", ["20", "30"]]}
  end

  #Está falhando mesmo. Tem que rever a regra de somatório com parenteses(caso ele tenha pedido)
  #E não está interpretanto o + 30 como soma, mas sim como uma string qqlr. 
  #Ex.: 
  ##  left:  {:ok, [["10", "20"]], " + 30"}
  ##  right: {:ok, [["10", "20"], "30"]}
  test "soma com parenteses" do
    assert GeorgeCompiler.Parser.parse("(10 - 20) + 30") == {:ok, [["10", "20"], "30"]}
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

  test "equals simples" do
    assert GeorgeCompiler.Parser.parse("10==20") == {:ok, ["10", "20"]}
  end

  #Está retornando 'array de array', mas creio que deva ser sim, já que a expressão retorna um 'array'
  test "booleano com parenteses <" do
    assert GeorgeCompiler.Parser.parse("5 < (10 -3)") == {:ok, ["5", [["10", "3"]]]}
  end

  test "atrib simples" do
    assert GeorgeCompiler.Parser.parse("a := 2") == {:ok,["a","2"]}
  end

  test "atrib simples com palavra" do
    assert GeorgeCompiler.Parser.parse("ab := 2") == {:ok,["ab","2"]}
  end

  test "atrib simples com numeros no nome" do
    assert GeorgeCompiler.Parser.parse("ab2 := 2") == {:ok,["ab2","2"]}
  end


  @doc """
    Testes da criação da pilha c
  """
  # Este teste está quebrando o parser
  #test "parser para pilha de controle(C) com vazio" do
  #  assert GeorgeCompiler.Parser.parse("") |> GeorgeCompiler.parseC == %Stack{elements: ["5"]}
  #end

  test "parser para pilha de controle(C) com 1 valor" do
    assert GeorgeCompiler.Parser.parse("5") |> GeorgeCompiler.SMC.parseC == %Stack{elements: ["5"]}
  end

  test "parser para pilha de controle(C) com 2 operandos" do
    assert GeorgeCompiler.Parser.parse("3+2") |> GeorgeCompiler.SMC.parseC == %Stack{elements: ["3","2"]}
  end

  test "parser para pilha de controle(C) com 3 operandos" do
    assert GeorgeCompiler.Parser.parse("5+7*2") |> GeorgeCompiler.SMC.parseC == %Stack{elements: ["5","7","2"]}
  end
end
