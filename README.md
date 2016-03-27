# Generic Tagging JSON API

I will be building a Generic Tagging JSON API that can store, retrieve, delete and report on the usage of a "tag" across different entities.

###Routes
```
 get 'stats/:type/:identifier', to: 'tags#entity_stats'
 get 'tags/:type/:identifier', to: 'tags#entity'
 get '/stats', to: 'tags#stats'
 post 'tags', to: 'tags#create'
 delete 'tags/:type/:identifier', to: 'tags#destroy'
```

### Create an Entry

```
POST /tag

- Entity Type, e.g. 'Product', 'Article'
- Entity Identifier, e.g. '1234', '582b5530-6cdb-11e4-9803-0800200c9a66'
- Tags, e.g. ['Large', 'Pink', 'Bike']

If the entity already exists it should replace it and all tags, not append to it

example curl request:

curl -H "Content-Type: application/json" -H 'Accept: application/json' -X POST -d '{"entity_type":"Company","entity_identifier":"4123", "tags":["Apple", "Computer", "Electronics"]}' http://localhost:3000/api/tags
```

### Retrieve an Entry

```
GET /tags/:entity_type/:entity_id

- should return a JSON representation of the entity and the tags it has assigned

example curl request:

curl -H "Content-Type: application/json" -H 'Accept: application/json' -X GET http://localhost:3000/api/tags/Company/4123
```

### Remove an Entry

```
DELETE /tags/:entity_type/:entity_id

Completely removes the entity and tags

example curl request:

curl -X "DELETE" http://localhost:3000/api/tags/Company/4123
```

### Retrieve Stats about all Tags

```
GET /stats

Retrives statistics about all tags

e.g. [{tag: 'Bike', count: 5}, {tag: 'Pink', count: 3}]

example curl request:

curl -H "Content-Type: application/json" -H 'Accept: application/json' -X GET http://localhost:3000/api/stats
```

### Retrieve Stats about a specific Entity

```
GET /stats/:entity_type/:entity_id

Retrives statistics about a specific tagged entity

example curl request:

curl -H "Content-Type: application/json" -H 'Accept: application/json' -X GET http://localhost:3000/api/stats/Company/4123
```
