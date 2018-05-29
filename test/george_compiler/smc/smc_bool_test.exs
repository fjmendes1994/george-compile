defmodule SMCBoolTest do
	@moduledoc false

	alias GeorgeCompiler.SMC, as: SMC

	use ExUnit.Case

	import GeorgeCompiler.SMC.Bool

	test "igualdade" do
		smc = SMC.new
				  |> SMC.add_value(5)
				  |> SMC.add_value(5)
	   
		assert equals(smc) == SMC.new |> SMC.add_value(true)
	end
	
	test "negação" do
		smc = SMC.new
        |> SMC.add_value(true) 
        
		assert nt(smc) == SMC.new |> SMC.add_value(false)
	end

	#Expressão: !(5==5)
	test "negação e igualdade" do
    smc = SMC.new
          |> SMC.add_value(5)
          |> SMC.add_value(5)

		assert equals(smc) |> nt == SMC.new |> SMC.add_value(false)
	end

	@doc "Testes para > e <"
	test "maior que verdadeiro" do
		smc = SMC.new
          |> SMC.add_value(5)
          |> SMC.add_value(3)

		assert greater_than(smc) == SMC.new |> SMC.add_value(true)
	end

	test "menor que verdadeiro" do
		smc = SMC.new
          |> SMC.add_value(3)
          |> SMC.add_value(5)
      
		assert lesser_than(smc) == SMC.new |> SMC.add_value(true)
	end

	test "maior que falso" do
		smc = SMC.new 
			|> SMC.add_value(3) 
			|> SMC.add_value(5) 
		assert greater_than(smc) == SMC.new |> SMC.add_value(false)
	end

	test "menor que falso" do
		smc = SMC.new 
			|> SMC.add_value(5) 
			|> SMC.add_value(3) 
		assert lesser_than(smc) == SMC.new |> SMC.add_value(false)
	end

	@doc "testes para >= e <="
	# MAIOR OU IGUAL
	test "maior igual que verdadeiro" do
		smc = SMC.new 
			|> SMC.add_value(5) 
			|> SMC.add_value(5) 
		assert greater_equals_than(smc) == SMC.new |> SMC.add_value(true)
	end

	test "maior igual que verdadeiro 2" do
		smc = SMC.new 
			|> SMC.add_value(6) 
			|> SMC.add_value(5) 
		assert greater_equals_than(smc) == SMC.new |> SMC.add_value(true)
	end

	test "maior igual que falso" do
		smc = SMC.new 
			|> SMC.add_value(6) 
			|> SMC.add_value(7) 
		assert greater_equals_than(smc) == SMC.new |> SMC.add_value(false)
	end

	#MENOR OU IGUAL
	test "menor igual que verdadeiro" do
		smc = SMC.new 
			|> SMC.add_value(5) 
			|> SMC.add_value(5) 
		assert lesser_equals_than(smc) == SMC.new |> SMC.add_value(true)
	end

	test "menor igual que verdadeiro 2" do
		smc = SMC.new 
			|> SMC.add_value(3) 
			|> SMC.add_value(5) 
		assert lesser_equals_than(smc) == SMC.new |> SMC.add_value(true)
	end

	test "menor igual que falso" do
		smc = SMC.new 
			|> SMC.add_value(5) 
      |> SMC.add_value(4) 
      
		assert lesser_equals_than(smc) == SMC.new |> SMC.add_value(false)
	end


	@doc "AND e OR"
	test "teste de and verdadeiro" do
		smc = SMC.new 
			|> SMC.add_value(true) 
			|> SMC.add_value(true) 
		assert bool_and(smc) == SMC.new |> SMC.add_value(true)
	end

	test "teste de and falso" do
		smc = SMC.new 
			|> SMC.add_value(true)
			|> SMC.add_value(false) 
		assert bool_and(smc) == SMC.new |> SMC.add_value(false)
	end

	test "teste de or verdadeiro" do
		smc = SMC.new 
			|> SMC.add_value(true)
			|> SMC.add_value(false) 
		assert bool_or(smc) == SMC.new |> SMC.add_value(true)
	end

	test "teste de or falso" do
		smc = SMC.new 
			|> SMC.add_value(false) 
			|> SMC.add_value(false) 
		assert bool_or(smc) == SMC.new |> SMC.add_value(false)
	end
end