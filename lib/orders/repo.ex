defmodule Orders.Repo do
  use Ecto.Repo,
    otp_app: :producer,
    adapter: Ecto.Adapters.Postgres
end
