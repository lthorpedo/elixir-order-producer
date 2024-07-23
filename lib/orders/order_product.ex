defmodule Order_Product do
  @derive {Jason.Encoder, except: [:__meta__]}
 use Ecto.Schema

 @primary_key false
 schema "order_product" do
  belongs_to :product, Product
  belongs_to :customer_order, Customer_Order
  field :quantity, :integer
 end
end
