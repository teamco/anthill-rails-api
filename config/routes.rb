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
      get '/users/:key', to: 'users#fetch_user'
      put '/users/:key', to: 'users#update'
      delete '/users/:key', to: 'users#destroy'

      post '/logout', to: 'users#logout'
      post '/force_logout', to: 'users#force_logout'

      get '/users/:user_key/websites', to: 'websites#index'
    end
  end
  # get '/pages', to: 'pages#index'
  # get '/pages/websites', to: 'pages#index'
  # get '/pages/websites/:id', to: 'pages#index'
  # get '/pages/websites/:id/widgets', to: 'pages#index'
  # get '/pages/websites/:id/development', to: 'pages#index'
  # get '/pages/widgets', to: 'pages#index'
  # get '/pages/widgets/:id', to: 'pages#index'
  #

  get '/websites/:id/widgets', to: 'websites#assigned_widgets'
  # post '/websites/:id/widgets', to: 'websites#assign_widgets'

  # root to: redirect('/pages')
end
