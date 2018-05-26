defmodule SMCTest do
  @moduledoc false
  alias GeorgeCompiler.SMC, as: SMC
  use ExUnit.Case

  test "Criação do SMC" do
    assert SMC.new == %SMC{
                        c: %Stack{elements: []},
                        m: %{},
                        s: %Stack{elements: []}
                      }
  end

  test "Inserção em S" do
    smc = SMC.new |> SMC.add_value(5)
    assert smc == %SMC{
                      c: %Stack{elements: []},
                      m: %{},
                      s: %Stack{elements: [5]}
                    }
  end

  test "Remoção de S" do
    smc = SMC.new |> SMC.add_value(5)
    assert SMC.pop_value(smc) == {5, %SMC{
                                      c: %Stack{elements: []},
                                      m: %{},
                                      s: %Stack{elements: []}
                                    }}
  end

  test "Inserção em C" do
    smc = SMC.new |> SMC.add_control(5)
    assert smc == %SMC{
                      c: %Stack{elements: [Tree.new(5)]},
                      m: %{},
                      s: %Stack{elements: []}
                    }
  end

  test "Remoção de C" do
    smc = SMC.new |> SMC.add_control(5)
    assert SMC.pop_control(smc) == {Tree.new(5), %SMC{
                                      c: %Stack{elements: []},
                                      m: %{},
                                      s: %Stack{elements: []}
                                    }}
  end

  test "Inserção em M" do
    smc = SMC.new |> SMC.add_store("var", 5)
    assert smc == %SMC{
                    c: %Stack{elements: []},
                    m: %{"var" => 5},
                    s: %Stack{elements: []}
                  }
  end

  test "Inserção dupla em M" do
    smc = SMC.new |> SMC.add_store("var", 5) |> SMC.add_store("var", 6)
    assert smc == %SMC{
                    c: %Stack{elements: []},
                    m: %{"var" => 6},
                    s: %Stack{elements: []}
                  }
  end
                  
  test "Limpeza da memoria" do
    smc = SMC.new |> SMC.add_store("var", 5) |> SMC.add_store("var", 6) |> SMC.clean_store
    assert smc == %SMC{
                    c: %Stack{elements: []},
                    m: %{},
                    s: %Stack{elements: []}
                  }
  end
end