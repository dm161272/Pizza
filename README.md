A customer has hired you to design a website that allows you to place food orders at home over the Internet.

Please note the following instructions for modeling the project database: For each client, we store a unique identifier, name, surname, address, zip code, location, province and telephone number. Location and province data will be stored in separate
tables.

We know that a locality belongs to a single province, and that a province can have many localities. For each location we store a unique identifier and a name. We store a unique identifier and name for each province.

A customer can place many orders, but a single order can only be placed by a single customer. Each order stores a unique identifier, date / time, whether the order is for home delivery or in-store collection, the number of products selected for each type and the total price. 
An order may consist of one or more products.
Products can be pizzas, burgers and drinks. Each product is stored: one unique identifier, name, description, image and price. 
In the case of pizzas there are several categories that they may change their name throughout the year. 
A pizza can only be in one category, but one category can have many
pizzas.
