defmodule EnvironmentTest do
	@moduledoc false

	use ExUnit.Case

	test "Criação do ambiente" do
		assert Environment.new() == %Environment{refs: []}
	end

	test "Cópia do ambiente" do
		environment = Environment.new
									|> Environment.add_ref("x")
      	
		assert Environment.new(environment) == environment
	end

	test "Adição de referência" do
  		assert %Environment{refs: [ab: _]} = Environment.new() |> Environment.add_ref("ab")
	end

	test "Adição de constante" do
		assert %Environment{refs: [ab: 5]} == Environment.new() |> Environment.add_const("ab",5)
  	end

	test "Recupera endereço" do
  		ambient = Environment.new() |> Environment.add_ref("ab")
  		assert Environment.get_address(ambient, "ab") == ambient.refs[String.to_atom("ab")]
	end

	test "Recupera contagem" do
  		ambient = Environment.new() |> Environment.add_ref("ab") |> Environment.add_ref("bc")
  		assert Environment.get_length(ambient) == 2
	end

	test "Recupera mais recente" do
  		ambient = Environment.new() |> Environment.add_ref("ab") |> Environment.add_ref("ab")
  		assert Environment.get_address(ambient, "ab") ==  ambient.refs[:ab]
	end
end