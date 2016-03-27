entity1 = Entity.create(entity_type: 'Product', identifier: '1234')
entity2 = Entity.create(entity_type: 'Article', identifier: '5678')
entity3 = Entity.create(entity_type: 'Business', identifier: '9102')

entity1.tags.create([
  {:name => "Computer"},
  {:name => "Bike"},
  {:name => "New"},
  {:name => 'Apple'}
])

entity2.tags.create([
  {:name => "Computer"},
  {:name => "New"},
  {:name => 'Apple'}
])

entity3.tags.create([
  {:name => "Computer"},
  {:name => "MacBook"},
  {:name => "Gunmetal"},
  {:name => "New"},
  {:name => 'Apple'}
])