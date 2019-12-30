Rails.application.routes.draw do
  #resources :meetings
  resources :events, :replace_id_with => 'url'

  get 'tasks/index'
  #get 'events/index'
  #get 'events/show'
  get 'meetings/index'
  post 'create' => 'events#create'
  get 'share/:id/:url' => 'events#share'
  get 'events/create/:id' => 'events#view'

  root 'meetings#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
