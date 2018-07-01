defmodule ABSTest do
	@moduledoc false

	use ExUnit.Case

	test "Novo abs com formals" do
			formals = Formals.new
							|> Formals.add_par(Par.new("var", "int"))
			assert ABS.new([formals, Tree.new(:blk)]) == %ABS{formals: formals, block: Tree.new(:blk)}
    end

	test "Novo abs sem formals" do
		assert ABS.new([Tree.new(:blk)]) == %ABS{block: Tree.new(:blk)}
	end

	test "Adicionando declaração ao bloco" do
		formals = Formals.new
							|> Formals.add_par(Par.new("var", "int"))
		abs = ABS.new([formals, Tree.new(:blk) |> Tree.add_leaf(Tree.new(:decl)) |> Tree.add_leaf(Tree.new(:seq))])
		assert ABS.add_dec(abs, Stack.new() |> Stack.push(2)) == %Tree{
																																		leafs: [
																																		%Tree{
																																				leafs: [
																																				%Tree{
																																						leafs: [
																																						%Tree{leafs: [], value: "var"},
																																						%Tree{leafs: [], value: 2}
																																						],
																																						value: :ref
																																				}
																																				],
																																				value: :decl
																																		},
																																		%Tree{leafs: [], value: :seq}
																																		],
																																		value: :blk
																																}
    end

	test "Adicionando declaração ao bloco sem declaração prévia" do
		formals = Formals.new
							|> Formals.add_par(Par.new("var", "int"))
		abs = ABS.new([formals, Tree.new(:blk) |> Tree.add_leaf(Tree.new(:seq))])
		assert ABS.add_dec(abs, Stack.new() |> Stack.push(2)) == %Tree{
																																		leafs: [
																																		%Tree{
																																				leafs: [
																																				%Tree{
																																						leafs: [
																																						%Tree{leafs: [], value: "var"},
																																						%Tree{leafs: [], value: 2}
																																						],
																																						value: :ref
																																				}
																																				],
																																				value: :decl
																																		},
																																		%Tree{leafs: [], value: :seq}
																																		],
																																		value: :blk
																																}
	end
end