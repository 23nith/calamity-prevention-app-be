Rails.application.routes.draw do
  get 'calamities/index'
  get 'calamities/show'
  get 'calamities/create'
  get 'calamities/update'
  get 'calamities/destroy'
  get 'areas/index'
  get 'areas/show'
  get 'areas/create'
  get 'areas/update'
  get 'areas/destroy'
  get '/current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  get '/areas' => 'areas#index'
  post '/area' => 'areas#show'
  post '/add_area' => 'areas#create'
  post '/edit_area' => 'areas#update'
  delete '/area' => 'areas#destroy'

  get '/calamities' => 'calamities#index'
  post '/calamity' => 'calamities#show'
  post '/add_calamity' => 'calamities#create'
  post '/edit_calamity' => 'calamities#update'
  delete '/calamity' => 'calamities#destroy'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
