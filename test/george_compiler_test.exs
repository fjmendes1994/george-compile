defmodule GeorgeCompilerTest do
  use ExUnit.Case
  doctest GeorgeCompiler

  test "greets the world" do
    assert GeorgeCompiler.hello() == :world
  end
end
