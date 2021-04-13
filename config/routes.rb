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
      get 'post/index'
      post :auth, to: 'authentication#create'
      get '/auth' => 'authentication#fetch'
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
  # resources :websites
  # get '/websites/:id/widgets', to: 'websites#assigned_widgets'
  # post '/websites/:id/widgets', to: 'websites#assign_widgets'

  # root to: redirect('/pages')
end
