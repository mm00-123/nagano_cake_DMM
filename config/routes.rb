Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    passwords: 'customers/passwords'
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }





  resources :customers do
    resources :cart_items
    delete 'cart_items' => 'cart_items#destroy_all', as: 'cart_all_item'
    resources :orders do
      resources :order_items
    end
    resources :shipping_addresses
  end
  put "/customers/:id/hide" => "customers#hide", as: 'customer_hide'

  get 'withdrawal' => 'customers#withdrawal'

  resources :items

  root 'homes#top'
  get '/about' => 'homes#about'
  get '/redirect' => 'homes#redirect'
  get '/contact-form' => 'homes#contact_form'




  namespace :admin do
    resources :genres
    resources :order_items
    resources :orders
    resources :customers
    resources :items
    get '/homes/top' => 'homes#top'
  end

  get '/customers/about' => 'homes#about', as: 'order_about'
  post '/customers/:member_id' => 'orders#create', as: 'order_create'
  get '/customers/:member_id/completion' => 'orders#completion', as: 'customer_order_completion'
  get '/:genre_id/items' => 'items#genre', as: 'genre_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

