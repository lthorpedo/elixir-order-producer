defmodule Inventory.Repo.Migrations.CreateInventory do
  use Ecto.Migration

  def change do
    create table(:stock) do
      add :productname, :string
      add :quantity, :integer
      add :warehouse, :string
    end
  end
end
