Rails.application.routes.draw do
  resources :companies do
    resources :rewards
    resources :comments
  end

  get '/users/:id', to: 'users#show'

  get '/users_list', to: 'admins#users_list'

  root controller: :main_page, action: :index
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  mount ActionCable.server => '/cable'
end
