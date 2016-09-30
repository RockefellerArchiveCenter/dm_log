Rails.application.routes.draw do
  resources :dm_items

  root 'dm_items#index'
  
  match ':controller(/:action(/:id))', :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
