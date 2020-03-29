Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :companies do
    resources :rewards do
      resources :paid_rewards
    end
    resources :news_records
    resources :comments
  end

  post '/tap2pay', to: 'webhooks#receive', as: :receive_webhooks

  get '/companies/:company_id/company_gallery', to: 'companies#company_gallery'
  post '/companies/:company_id/add_image', to: 'companies#add_image'
  get '/companies/:company_id/donation', to: 'donations#index'

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
