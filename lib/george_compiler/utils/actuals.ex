defmodule Actuals do
  defstruct items: []

  alias GeorgeCompiler.SMC.Arit, as: Arit
  alias GeorgeCompiler.SMC.Bool, as: Bool
  alias GeorgeCompiler.SMC, as: SMC

  def get_values(%Actuals{items: items}) do
    SMC.new
    |> add_items(items)
    |> solve_expressions
    |> return_value
  end

  defp add_items(smc, items) when length(items) > 0 do
    smc
    |> SMC.add_control(Enum.at(items, 0))
    |> add_items(Enum.drop(items, 1))
  end

  defp add_items(smc, items) when length(items) == 0 do
    smc
  end

  defp solve_expressions(smc) do
    if Stack.depth(smc.c) > 0 do
      {tree, smc} = SMC.pop_control(smc)
      unless Tree.is_leaf(tree) do 
        cond do
          Arit.is_arit_exp(tree.value) -> Arit.arit_decompose_tree(tree, smc) |> solve_expressions
          Bool.is_bool_exp(tree.value) -> Bool.bool_decompose_tree(tree, smc) |> solve_expressions
        end
      else
        cond do
          Arit.is_arit_exp(tree.value) -> Arit.arit_exp(tree.value, smc) |> solve_expressions
          Bool.is_bool_exp(tree.value) -> Bool.bool_exp(tree.value, smc) |> solve_expressions
          true -> SMC.add_value(smc, tree.value) |> solve_expressions
        end 
      end
    else
      smc
    end
  end

  defp return_value(smc), do: Stack.reverse(smc.s)
end