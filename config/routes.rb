Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    passwords: 'customers/passwords'
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }



  namespace :public do
    resources :items
    resources :customers
    resources :cart_items
    resources :customers
    delete 'cart_items' => 'cart_items#destroy_all', as: 'cart_all_item'
    resources :orders do
      resources :order_items
    end
    resources :addresses
  end

  get 'out' => 'public/customers#out', as: 'customer_out'

  root 'public/homes#top'

  get 'check' => 'public/customers#check'
  get '/about' => 'public/homes#about'
  post 'orders/about' => 'public/orders#about', as: 'order_about'
  get 'thanx' => 'public/orders#thanx'
  



  namespace :admin do
    resources :genres
    resources :order_items
    resources :orders
    resources :customers

    resources :items
    get '/homes/top' => 'homes#top'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

