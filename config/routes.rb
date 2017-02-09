Rails.application.routes.draw do
  post '/tag' => 'entities#create'
  get '/tags/:entity_type/:entity_id' => 'entities#show'
  delete '/tags/:entity_type/:entity_id'=> 'entities#destroy'

  get '/stats' => 'entities#stats'
  get '/stats/:entity_type/:entity_id'=>'entities#get_individual_stat'
end
