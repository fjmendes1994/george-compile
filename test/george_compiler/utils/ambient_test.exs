defmodule AmbientTest do
    @moduledoc false

    use ExUnit.Case

    test "Criação do ambiente" do
        assert Ambient.new() == %Ambient{refs: []}
    end

    test "Adição de referência" do
        assert %Ambient{refs: [ab: _]} = Ambient.new() |> Ambient.add_ref("ab")
    end

    test "Recupera endereço" do
        ambient = Ambient.new() |> Ambient.add_ref("ab")
        assert Ambient.get_address(ambient, "ab") == ambient.refs[String.to_atom("ab")]
    end

    test "Recupera contagem" do
        ambient = Ambient.new() |> Ambient.add_ref("ab") |> Ambient.add_ref("bc")
        assert Ambient.get_length(ambient) == 2
    end

    test "Recupera mais recente" do
        ambient = Ambient.new() |> Ambient.add_ref("ab") |> Ambient.add_ref("ab")
        assert Ambient.get_address(ambient, "ab") ==  ambient.refs[:ab]
    end
end