# Order Producer

Order creation app (by Levi)

* Generates simulated order events
* Stores order details in PostgreSQL
* Publishes "OrderCreated" events to Kafka


## Getting Started

* Clone the repository
* cd elixir-order-producer (or whatever you called the repos)
* run `docker-compose up -d`
* go to http://localhost:8080 and create two topics, one named "OrderCreated" and another named "InventoryUpdated" ... both should just have a single partition. All other fields should be optional.
* run `mix deps.get`
* run `mix ecto.setup` - this should create the database in postgres & populate the database with some seed data.

From here you can start the other service (elixir-inventory-consumer) at any point

* run `iex -S mix`
* Create an order in iex, and example of this is `OrderService.create_order "Levi", [%{name: "MRE", qty: 18},%{name: "mri", qty: 1},%{name: "spacesuit", qty: 1},%{name: "rocket", qty: 1},%{name: "booster", qty: 2},%{name: "telescope", qty: 8}]`
* to query the database you can run these commands
  * `docker exec -it elixir-order-producer-postgresdb-1 bash` (your container may have a different name)
  * `psql -U postgres`
  * `\c orders`
  * `select * from customer_order;`
  * `select co.id as customer_order_id, total_price, customer, purchase_date, op.quantity, p.name, p.price from customer_order co join order_product op on co.id = op.customer_order_id join product p on op.product_id = p.id where co.id = _REPLACE_ME_WITH_ID_;`