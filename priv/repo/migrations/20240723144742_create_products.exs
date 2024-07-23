defmodule Orders.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :name, :string
      add :price, :float
    end
  end
end
