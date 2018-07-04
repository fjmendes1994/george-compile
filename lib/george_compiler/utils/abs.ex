defmodule ABS do
  defstruct formals: nil, block: nil

  def new(leafs) when length(leafs) == 2 do
    %ABS{formals: Enum.at(leafs, 0), block: Enum.at(leafs, 1)}
  end
  
  def new(leafs) when length(leafs) == 1 do
    %ABS{block: Enum.at(leafs, 0)}
  end

  def add_dec(%ABS{formals: formals, block: blk} , values) do
    leafs = add_references(formals.items, values, blk)
    %Tree{leafs: leafs, value: :blk}
  end

  defp add_references(ids, values, blk = %Tree{leafs: leafs} ) when length(leafs) > 1 do
    [decl, coms] = leafs
    [append_declarations(decl, ids, values)] ++ [coms]
  end

  defp add_references(ids, values, blk = %Tree{leafs: [leafs]} ) do
    [append_declarations(Tree.new(:decl), ids, values)] ++ [leafs]
  end

  defp append_declarations(decl, ids, values) do
    if length(ids) <= 0 do
      decl
    else
      {value, values} = Stack.pop(values)
      Tree.add_leaf(decl, Tree.new(:ref) |> Tree.add_leaf(Enum.at(ids, 0).id) |> Tree.add_leaf(value))
      |> append_declarations(Enum.drop(ids, 1), values)
    end
  end
end