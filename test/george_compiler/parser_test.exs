defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case

  test "soma simples" do
    assert GeorgeCompiler.Parser.parse("11+ 20 + 30") == {:ok, ["11", ["20", "30"]]}
  end

end
