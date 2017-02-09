# The main files worked on are

Controller
 
 controller/entities_controller

Model
 
 model/entity.rb

Specs
 
 spec/requests/stats_spec.rb
 spec/requests/tags_spec.rb


# Create an Entry

POST /tag

- Entity Type, e.g. 'Product', 'Article'
- Entity Identifier, e.g. '1234', '582b5530-6cdb-11e4-9803-0800200c9a66'
- Tags, e.g. ['Large', 'Pink', 'Bike']

If the entity already exists it should replace it and all tags, not append to it

# Retrieve an Entry

GET /tags/:entity_type/:entity_id

- should return a JSON representation of the entity and the tags it has assigned

# Remove an Entry

DELETE /tags/:entity_type/:entity_id

Completely removes the entity and tags

# Retrieve Stats about all Tags

GET /stats

Retrives statistics about all tags

e.g. [{tag: 'Bike', count: 5}, {tag: 'Pink', count: 3}]

Retrieve Stats about a specific Entity

GET /stats/:entity_type/:entity_id

Retrives statistics about a specific tagged entity


# USAGE USING CURL IN COMMANDLINE

POST /tag

$ curl -H "Content-Type: application/json" -X POST -d '{"entity_type":"Product","entity_id":"1234", "tags": ["Blue","Small"]}' http://localhost:3000/tag

GET /tags/:entity_type/:entity_id

$ curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:3000/tags/Product/1234

DELETE /tags/:entity_type/:entity_id

$ curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X DELETE http://localhost:3000/tags/Product/1234

GET /stats

$ curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:3000/stats

GET /stats/:entity_type/:entity_id

$ curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:3000/stats/Product/1234


# RUN THE TESTS WITH

$ rspec spec/requests
