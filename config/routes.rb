Rails.application.routes.draw do
  get 'dm_items/index'

  get 'dm_items/show'

  get 'dm_items/new'

  get 'dm_items/edit'

  get 'dm_items/delete'
  
  get 'dm_items/:refid' => 'dm_item#refid'

  root 'dm_items#index'
  
  match ':controller(/:action(/:id))', :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
