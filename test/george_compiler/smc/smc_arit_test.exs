defmodule SMCAritTest do
	@moduledoc false

	alias GeorgeCompiler.SMC, as: SMC
	
	use ExUnit.Case
	
	test "Adição" do
		assert  create_smc(2, 1) |> GeorgeCompiler.SMC.Arit.add  == SMC.new() |> SMC.add_value(3)   
	end

	test "Subtração" do
		assert create_smc(2, 1) |> GeorgeCompiler.SMC.Arit.sub  == SMC.new() |> SMC.add_value(1)   
	end

	test "Multiplicação" do
		assert create_smc(2, 1) |> GeorgeCompiler.SMC.Arit.mul  == SMC.new() |> SMC.add_value(2)
	end

	test "Divisão" do
		assert create_smc(2, 1) |> GeorgeCompiler.SMC.Arit.div  == SMC.new() |> SMC.add_value(2)   
	end
	
	defp create_smc(a, b) do
		SMC.new() 
		|> SMC.add_value(a) 
		|> SMC.add_value(b) 
	end

	test "Divisão da árvore" do
		tree = Tree.new(:add) 
			   |> Tree.add_leaf(5) 
			   |> Tree.add_leaf(3)

		decomposed = SMC.new 
					|> SMC.add_control(:add) 
					|> SMC.add_control(Tree.new(3))
					|> SMC.add_control(Tree.new(5))

		assert GeorgeCompiler.SMC.Arit.arit_decompose_tree(tree, SMC.new) == decomposed
	end
end