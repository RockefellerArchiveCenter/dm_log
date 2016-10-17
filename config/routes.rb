Rails.application.routes.draw do
  get 'sessions/new'

  get 'signup'  => 'users#new'
  
  get 'login' => 'sessions#new'
  
  post 'login' => 'sessions#create'
  
  delete 'logout' => 'sessions#destroy'
  
  get 'dm_items/:id/json' => 'api/v0#dm_item'
  
  resources :users

  resources :dm_items, except: :destroy

  root 'dm_items#index'
  
  # match ':controller(/:action(/:id))', :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
