defmodule Customer_Order do
  @derive {Jason.Encoder, except: [:products, :__meta__]}
 use Ecto.Schema

 schema "customer_order" do
  field :total_price, :float
  field :customer, :string
  field :purchase_date, :utc_datetime
  many_to_many :products, Product, join_through: Order_Product
 end
end
