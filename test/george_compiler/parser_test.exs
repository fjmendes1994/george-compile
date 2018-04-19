defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case


  test "operacoes aritimeticas" do
    assert GeorgeCompiler.Parser.parse!("2 + 2 - -2 + 2 * 3 / 3 % 3" ) == ["2", "+", ["2", "-", ["-2", "+", ["2", "*", ["3", "/", ["3", "%", "3"]]]]]]
  end

  test "operacoes booleanas" do
    assert GeorgeCompiler.Parser.parse!("2 > 3" )  == ["2", ">", "3"]
    assert GeorgeCompiler.Parser.parse!("2 >= 3" )  == ["2", ">=", "3"]
    assert GeorgeCompiler.Parser.parse!("-2 == -3" )  == ["-2", "==", "-3"]
    assert GeorgeCompiler.Parser.parse!("2 < 3" )  == ["2", "<", "3"]
    assert GeorgeCompiler.Parser.parse!("2 <= 3" )  == ["2", "<=", "3"]
  end

 test "atribuicao simples" do
   assert GeorgeCompiler.Parser.parse!("ab := 2" )
 end

 test "atribuicao expressoes aritimeticas" do
   assert GeorgeCompiler.Parser.parse!("ab := 2 + 3" )
 end

 test "atribuicao expressoes booleanas" do
   assert GeorgeCompiler.Parser.parse!("ab := 2 > 3" )
 end

end
