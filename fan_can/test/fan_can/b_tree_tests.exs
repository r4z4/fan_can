defmodule FanCan.TreesTest do
  use ExUnit.Case

  test "new" do
    assert BTree.new(10) 
      == %BTree{tree: {10, nil, nil}}
  end

  test "insert same" do
    assert BTree.new(10) |> BTree.insert(10)
      == %BTree{tree: {10, nil, nil}}
  end

  test "insert lower" do
    assert BTree.new(10) |> BTree.insert(5)
      == %BTree{tree: {10, {5, nil, nil}, nil}}
  end

  test "insert higher" do
    assert BTree.new(10) |> BTree.insert(15) 
      == %BTree{tree: {10, nil, {15, nil, nil}}}
  end

  test "insert lower then higher" do
    assert BTree.new(10) |> BTree.insert(5) |> BTree.insert(15) 
      == %BTree{tree: {10, {5, nil, nil}, {15, nil, nil}}}
  end

  test "insert higher then lower" do
    assert BTree.new(10) |> BTree.insert(15) |> BTree.insert(5)
      == %BTree{tree: {10, {5, nil, nil}, {15, nil, nil}}}
  end

  test "search empty" do
    assert BTree.search(%BTree{tree: nil}, 1) == false
  end

  test "search found" do
    assert BTree.new(10) |> BTree.search(10)
      == true
  end

  test "search not found" do
    assert BTree.new(10) |> BTree.search(1)
      == false
  end

  test "search higher found" do
    assert BTree.new(10) |> BTree.insert(15) |>  BTree.search(15)
      == true
  end

  test "search lower found" do
    assert BTree.new(10) |> BTree.insert(5) |> BTree.search(5)
      == true
  end

   test "search higher not found" do
    assert BTree.new(10) |> BTree.insert(15) |> BTree.search(20)
      == false
  end

  test "search lower not found" do
    assert BTree.new(10) |> BTree.insert(5) |> BTree.search(1)
      == false
  end
  
end