Rails.application.routes.draw do
  get "admin" => "admin#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  resources :products

  resource  :session
  resources :passwords, param: :token

  scope "(:locale)" do
    get "questions" => "store#questions", as: :questions
    get "news" => "store#news", as: :news
    get "contact" => "store#contact", as: :contact

    resources :orders
    resources :line_items do
      patch :decrement, on: :member
    end
    resources :carts

    root "store#index", as: "store_index", via: :all
  end
end
