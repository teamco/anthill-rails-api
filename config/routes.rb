Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :widgets
  namespace :secured do
    resources :user_logs
  end

  devise_for :users,
             controllers: {
               registrations: :registrations,
               sessions: :sessions
             }

  namespace :api do
    namespace :v1 do
      post :auth, to: 'authentication#create'
      get '/auth', to: 'authentication#fetch'

      get '/current_user', to: 'users#fetch'
      get '/all_users', to: 'users#all_users'
      get '/users/:user_key', to: 'users#fetch_user'
      put '/users/:user_key', to: 'users#update'
      delete '/users/:user_key', to: 'users#destroy'

      post '/logout', to: 'users#logout'
      post '/force_logout', to: 'users#force_logout'

      get '/users/:user_key/websites', to: 'websites#index'
      get '/users/:user_key/websites/:website_key', to: 'websites#show'
      post '/users/:user_key/websites', to: 'websites#create'
      put '/users/:user_key/websites/:website_key', to: 'websites#update'
      delete '/users/:user_key/websites/:website_key', to: 'websites#destroy'

      get '/users/:user_key/widgets', to: 'widgets#index'
      get '/users/:user_key/widgets/:widget_key', to: 'widgets#show'
    end
  end

  # get '/websites/:id/widgets', to: 'websites#assigned_widgets'
  # post '/websites/:id/widgets', to: 'websites#assign_widgets'
end
