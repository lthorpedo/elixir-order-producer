defmodule OrderServiceTest do
  use ExUnit.Case
  doctest OrderService

  test "creates a valid order" do
    assert OrderService.create_order("test customer", [%{name: "MRE", qty: 1}]) == :order_placed
  end

  test "attempts an invalid order" do
    assert OrderService.create_order("bad customer/ hacker",
      [%{name: "this product should never exist", qty: 9876}]) == :no_valid_products
  end

  test "attempts order with valid & invalid products" do
    assert OrderService.create_order("ex-hacker",
      [%{name: "this product should never exist", qty: 9876},
       %{name: "", qty: 1},
       %{name: "spacesuit", qty: 1}]) == :some_invalid_products
  end
end
