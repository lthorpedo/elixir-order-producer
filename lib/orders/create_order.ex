defmodule OrderService do

  def create_order(customer, user_products) do
    products = Enum.filter(user_products, fn(x) -> get_product(x.name).id > 0 end)
    if (length(products) < 1) do
      IO.puts("No valid products purchased")
    else
      create_order_follow(customer, products)
    end
  end

  defp create_order_follow(customer, products) do
    total = Enum.reduce(products, 0.0, fn(x, acc) -> acc + (get_product(x.name).price * x.qty) end)

    ord =%Customer_Order{
      customer: customer,
      purchase_date: DateTime.truncate(DateTime.utc_now, :second),
      total_price: total
    }

    {:ok, dbOrder} = Orders.Repo.insert ord
    if :ok do
      IO.puts("Order Created")
      IO.inspect(dbOrder)
    else
      IO.puts("Failed to insert order to db")
    end

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
