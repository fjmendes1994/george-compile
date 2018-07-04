defmodule Actuals do
  defstruct items: []

  alias GeorgeCompiler.SMC.Arit, as: Arit
  alias GeorgeCompiler.SMC.Bool, as: Bool
  alias GeorgeCompiler.SMC, as: SMC

  import GeorgeCompiler.SMC.Attribution, only: [get_variable_value: 2]

  def get_values(%Actuals{items: items}, smc) do
    SMC.new
    |> add_items(items)
    |> solve_expressions(smc)
    |> return_value
  end

  defp get_parameters_values(items, smc) do
    [get_parameters_values(Enum.at(items.value, 0), smc)] ++ get_parameters_values(Enum.drop(items, 1), smc)
  end

  defp add_items(smc, items) when length(items) > 0 do
    smc
    |> SMC.add_control(Enum.at(items, 0))
    |> add_items(Enum.drop(items, 1))
  end

  defp add_items(smc, items) when length(items) == 0 do
    smc
  end

  defp solve_expressions(smc, context) do    
    if Stack.depth(smc.c) > 0 do
      {tree, smc} = SMC.pop_control(smc)
      unless Tree.is_leaf(tree) do 
        cond do
          Arit.is_arit_exp(tree.value) -> Arit.arit_decompose_tree(tree, smc) |> solve_expressions(context)
          Bool.is_bool_exp(tree.value) -> Bool.bool_decompose_tree(tree, smc) |> solve_expressions(context)
        end
      else
        cond do
          Arit.is_arit_exp(tree.value) -> Arit.arit_exp(tree.value, smc) |> solve_expressions(context)
          Bool.is_bool_exp(tree.value) -> Bool.bool_exp(tree.value, smc) |> solve_expressions(context)
          true -> SMC.add_value(smc, get_variable_value(tree.value, context)) |> solve_expressions(context)
        end 
      end
    else
      smc
    end
  end

  defp return_value(smc), do: smc.s
end