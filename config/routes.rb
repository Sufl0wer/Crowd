Rails.application.routes.draw do
  resources :companies
  resources :rewards

  get '/user_page', to: 'users#user_page'

  root controller: :main_page, action: :index
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
