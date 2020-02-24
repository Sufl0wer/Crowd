Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :companies do
    resources :rewards do
      resources :paid_rewards
    end
    resources :news_records
    resources :comments
  end

  post '/companies/:company_id/donate', to: 'donations#donate'

  get '/users/:id', to: 'users#show'
  post '/users/:id/change_avatar', to: 'users#change_avatar'

  controller 'admins' do
    match 'users_list', action: :users_list, via: :get
    match 'change_role/:user_id', action: :change_role, via: :post
  end

  root controller: :web_site, action: :index
  controller 'web_site' do
    match 'search', action: :search, via: :get
    match 'switch_theme', action: :switch_theme, via: :get
  end

  mount ActionCable.server => '/cable'
end
