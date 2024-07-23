case Mix.env() do
  :dev ->
    IO.puts("Let's add some data!")
    {:ok, product_a} = Orders.Repo.insert %Product{ name: "rocket", price: 1800000.0}
    {:ok, product_b} = Orders.Repo.insert %Product{ name: "spacesuit", price: 1951.69}
    {:ok, product_c} = Orders.Repo.insert %Product{ name: "booster", price: 109876.54}
    {:ok, product_d} = Orders.Repo.insert %Product{ name: "planet", price: 9999999.99}
    {:ok, product_e} = Orders.Repo.insert %Product{ name: "MRE", price: 15.15}
    {:ok, product_f} = Orders.Repo.insert %Product{ name: "telescope", price: 261.0}
    {:ok, product_0} = Orders.Repo.insert %Product{ name: "sword", price: 99.95}
    {:ok, product_1} = Orders.Repo.insert %Product{ name: "shield", price: 201.0}
    {:ok, product_2} = Orders.Repo.insert %Product{ name: "helmet", price: 35.18}
    {:ok, product_3} = Orders.Repo.insert %Product{ name: "armor", price: 123.45}
    {:ok, product_4} = Orders.Repo.insert %Product{ name: "baseball", price: 5.99}
    {:ok, product_5} = Orders.Repo.insert %Product{ name: "soccer", price: 16.16}
    {:ok, product_6} = Orders.Repo.insert %Product{ name: "football", price: 13.0}
  _ ->
    nil
end
