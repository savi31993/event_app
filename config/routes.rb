Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/', to: 'categories#index'

  get '/event_manager', to: 'events#manager'

  post '/change_status', to: 'events#change_status'

  resources :categories
  resources :events
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
