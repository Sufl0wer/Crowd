Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :companies do
    resources :rewards do
      resources :paid_rewards
    end
    resources :comments
  end

  post '/companies/:company_id/donate', to: 'donations#donate'

  get '/users/:id', to: 'users#show'

  get '/users_list', to: 'admins#users_list'

  root controller: :web_site, action: :index
  controller 'web_site' do
    match 'search', action: :search, via: :get
  end

  mount ActionCable.server => '/cable'
end
