Rails.application.routes.draw do
  post '/tag' => 'entities#create', defaults: {format: :json}
  get '/tags/:entity_type/:entity_id' => 'entities#show', defaults: {format: :json}
  delete '/tags/:entity_type/:entity_id'=> 'entities#destroy',defaults: {format: :json}

  get '/stats' => 'entities#stats', defaults: {format: :json}
  get '/stats/:entity_type/:entity_id'=>'entities#get_individual_stat', defaults: {format: :json}
end
