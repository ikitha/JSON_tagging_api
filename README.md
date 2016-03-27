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

###Notes
For the associations I chose that Entities have many Tags and Tags belong to an Entity. I did not validate uniqueness of tag names for the purpose of them being repeated across different entities and remain independent in that sense. However, tag names may not be repeated under a single entity.

For the create action I contemplated the paths I could take for a bit. "If the entity already exists it should replace it and all tags, not append to it" Upon the post request, I do a find or create by for the Entity. This executes SQL that searches if the record already exists and does a create if it doesn't. I decided to search by both type and identifier for the entity, and if those two matched, there would be no point to delete the record and recreate it, however I do clear the tags regardless. 

The other sticking point I thought more about the planning of was the `GET /stats/:entity_type/:entity_id` and `GET /tags/:entity_type/:entity_id` routes and the difference between them. I eventually settled on the idea that the tags version was clearly to show the entity and the tags. The stats version I added an additional set of data that gets the overall occurence of that entity's tags. 

The final touch I added was that I found there could be an issue with capital letters. Say someone creates an entity_type of "Company" and someone else searches "company" in a GET request; you wouldn't get the result. I went back and downcased everything on both inserts and reads. 
