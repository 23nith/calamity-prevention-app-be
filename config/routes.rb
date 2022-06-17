Rails.application.routes.draw do
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
  
  get '/accounts' => 'users#index'
  post '/account' => 'users#show'
  post '/add_account' => 'users#create'
  post '/edit_account' => 'users#update'
  delete '/account' => 'users#destroy'
  
  get '/needs' => 'needs#index'
  post '/need' => 'needs#show'
  post '/add_need' => 'needs#create'
  post '/edit_need' => 'needs#update'
  delete '/need' => 'needs#destroy'
  
  get '/messages' => 'messages#index'
  post '/message' => 'messages#show'
  post '/add_message' => 'messages#create'
  post '/edit_message' => 'messages#update'
  delete '/message' => 'messages#destroy'
  
  get '/donations' => 'donations#index'
  post '/donation' => 'donations#show'
  post '/add_donation' => 'donations#create'
  post '/source' => 'donations#source'
  post '/payment' => 'donations#payment'
  post '/webhook' => 'webhook#create'
  post '/listen' => 'webhook#listen'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
