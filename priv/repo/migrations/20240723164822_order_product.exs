defmodule Orders.Repo.Migrations.OrderProduct do
  use Ecto.Migration

  def change do
    create table(:order_product, primary_key: false) do
      add(:customer_order_id, references(:customer_order, on_delete: :delete_all), primary_key: true)
      add(:product_id, references(:product, on_delete: :delete_all), primary_key: true)
      add :quantity, :integer
    end

    create(index(:order_product, [:customer_order_id]))
    create(index(:order_product, [:product_id]))
  end
end
