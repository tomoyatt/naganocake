Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about"
    resources :items,       only: [:index, :show]
    get 'customers/my_page' => "customers#show"
    get 'customers/edit' => "customers#edit"
    patch 'customers' => "customers#update"
    get 'customers/unsubscribe' => "customers#unsubscribe"
    patch 'customers/withdraw' => "customers#withdraw"
    get 'cart_items' => "cart_items#index"
    patch 'cart_items/:id' => "cart_items#update"
    delete 'cart_items/:id' => "cart_items#destroy"
    delete 'cart_items/destroy_all' => "cart_items#destroy_all"
    post 'cart_items' => "cart_items#create"
    get 'orders/new' => "orders#new"
    post 'orders/confirm' => "orders#confirm"
    get 'orders/conplete' => "orders#conplete"
    post 'orders' => "orders#create"
    get 'orders' => "orders#index"
    get 'orders/:id' => "orders#show"
    resources :addresses,   only: [:index, :edit, :create, :update, :destroy]
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "homes#top"
    resources :items,         only: [:new, :create, :index, :show, :edit, :update]
    resources :genres,        only: [:index, :create, :edit, :update]
    resources :customers,     only: [:index, :show, :edit, :update]
    resources :orders,        only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
