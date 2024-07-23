defmodule Product do
  @derive {Jason.Encoder, except: [:orders, :__meta__]}
 use Ecto.Schema

 schema "product" do
  field :name, :string
  field :price, :float
  many_to_many :orders, Customer_Order, join_through: Order_Product
 end

  def show_products do
    Product |> Orders.Repo.all
  end
end
