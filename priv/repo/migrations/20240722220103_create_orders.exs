defmodule Orders.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:customer_order) do
      add :total_price, :float
      add :customer, :string
      add :purchase_date, :utc_datetime
    end
  end
end
