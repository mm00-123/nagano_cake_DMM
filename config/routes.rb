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
    resources :addresses
  end
  get 'check' => 'public/customes#check'

  resources :items

  root 'public/homes#top'
  get '/about' => 'public/homes#about'




  namespace :admin do
    resources :genres
    resources :order_items
    resources :orders
    resources :customers
    resources :items
    get '/homes/top' => 'homes#top'
  end

  get '/customers/about' => 'homes#about', as: 'order_about'
  post '/customers/:customer_id' => 'orders#create', as: 'order_create'
  get '/:genre_id/items' => 'items#genre', as: 'genre_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

