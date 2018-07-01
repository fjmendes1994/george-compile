defmodule ABS do
  defstruct formals: nil, block: nil

  def new(leafs) when length(leafs) == 2 do
    %ABS{formals: Enum.at(leafs, 0), block: Enum.at(leafs, 1)}
  end
  
  def new(leafs) when length(leafs) == 1 do
    %ABS{block: Enum.at(leafs, 0)}
  end

  def add_dec(%ABS{formals: formals, block: blk} , values) do
    leafs = add_references(formals, values, blk.leafs)
    %Tree{leafs: leafs, value: :blk}
  end

  defp add_references(ids, values, blk = [%Tree{leafs: decl} | coms]) when length(blk) == 2 do
    [%Tree{value: :decl, leafs: append_declarations(decl, ids, values)} | coms]
  end

  defp add_references(ids, values, blk = [coms| _]) when length(blk) == 1 do
    [%Tree{value: :decl, leafs: append_declarations([], ids, values)} | [coms]]
  end

  defp append_declarations(decl, ids, values) do
    if length(ids) <= 0 do
      decl
    else
      {value, values} = Stack.pop(values)
      decl ++ [Tree.new(:ref) |> Tree.add_leaf(Enum.at(ids, 0)) |> Tree.add_leaf(value)]
      |> append_declarations(Enum.drop(ids, 1), values)
    end
  end
end