Rails.application.routes.draw do
# GET /stats/:entity_type/:entity_id
# GET /stats
# DELETE /tags/:entity_type/:entity_id
# GET /tags/:entity_type/:entity_id
# POST /tag
  namespace :api, path: 'api/', defaults: { format: 'json' } do
    get 'stats/:entity_type/:entity_identifier', to: 'tags#entity_stats'
    get 'tags/:entity_type/:entity_identifier', to: 'tags#entity'
    get 'stats', to: 'tags#stats'
    post 'tags', to: 'tags#create'
    delete 'tags/:entity_type/:entity_identifier', to: 'tags#destroy'
  end
end
