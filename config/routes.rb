Rails.application.routes.draw do
  devise_for :users, controllers: {
          registrations: 'users/registrations',
          sessions: 'users/sessions'
        }
        
  get 'sessions/new'

  get 'signup'  => 'users#new'
  
  get 'login' => 'sessions#new'
  
  post 'login' => 'sessions#create'
  
  delete 'logout' => 'sessions#destroy'
  
  namespace :api do
    get 'dm_items/:id' => 'v0#show'
  end 
    
  
  resources :users

  resources :dm_items, except: :destroy

  root 'dm_items#index'
  
  # match ':controller(/:action(/:id))', :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
