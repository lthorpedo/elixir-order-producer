# Order Producer

Order creation app (by Levi)

* Generates simulated order events
* Stores order details in PostgreSQL
* Publishes "OrderCreated" events to Kafka


## Getting Started

* Clone the repository
* cd elixir-order-producer (or whatever you called the repos)
* run `docker-compose up -d`
* run `mix deps.get`
* run `mix ecto.setup` - this should create the database in postgres & populate the database with some seed data.

From here you can start the other service (elixir-inventory-consumer) at any point

* run `iex -S mix`
* Create an order in iex, and example of this is `OrderService.create_order "Levi", [%{name: "MRE", qty: 18},%{name: "rocket", qty: 1},%{name: "spacesuit", qty: 2}]`
* to query the database you can run these commands
  * `docker exec -it elixir-order-producer-postgresdb-1 bash` (your container may have a different name)
  * `psql -U postgres`
  * `\c orders`
  * `select * from customer_order;`