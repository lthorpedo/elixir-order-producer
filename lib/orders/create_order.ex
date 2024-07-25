defmodule OrderService do

  def create_order(customer, user_products) when is_list(user_products) and is_binary(customer) do
    groups = Enum.group_by(user_products, fn(x) -> get_product(x.name).id > 0 end)
    products = groups[true]
    invalidPs = groups[false]
    cond do
      (products == nil || length(products) < 1) ->
        IO.puts("No valid products purchased")
        :no_valid_products
      (invalidPs != nil && length(invalidPs) > 0) ->
        create_order_for_valid_products(customer, products)
        IO.puts "Invalid products"
        invalidPs |> Enum.each(&(IO.puts &1.name ))
        :some_invalid_products
      true ->
        create_order_for_valid_products(customer, products)
        :order_placed
    end
  end

  defp create_order_for_valid_products(customer, products) do
    total = Enum.reduce(products, 0.0, fn(x, acc) -> acc + (get_product(x.name).price * x.qty) end)

    ord =%Customer_Order{
      customer: customer,
      purchase_date: DateTime.truncate(DateTime.utc_now, :second),
      total_price: total
    }

    case Orders.Repo.insert ord do
      {:ok, dbOrder} ->
        IO.puts("Order Created")
        create_order_product_quantities(products, dbOrder)
      {:error, _changeset} ->
        IO.puts("Failed to insert order to db")
    end
  end

  defp create_order_product_quantities(products, dbOrder) do
    products |> Enum.each(fn(x) ->
      prd = get_product(x.name)
      ord_prd =%Order_Product{
        product_id: prd.id,
        customer_order_id: dbOrder.id,
        quantity: x.qty
      }
      Orders.Repo.insert ord_prd
    end)

    val = Jason.encode!(dbOrder)
    KafkaEx.produce("OrderCreated", 0, val)
  end

  defp get_product(name) do
    case Product |> Orders.Repo.get_by(name: name) do
      nil ->
        %Product{id: 0, price: 0.0, name: ""}
      resource ->
        resource
    end
  end

end
