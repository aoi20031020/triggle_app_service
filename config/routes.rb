# config/routes.rb
Rails.application.routes.draw do
  resources :logs, only: [ :create ]

  # api 名前空間内での設定
  namespace :api do
    resource :result, only: [ :show, :create ]  # 単数形のリソースとして設定
  end
end
