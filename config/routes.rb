Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about"
    resources :items,       only: [:index, :show]
    resources :cart_items,  only: [:index, :update, :destroy, :create]
    resources :orders,      only: [:new, :create, :index, :show]
    resources :addresses,   only: [:index, :edit, :create, :update, :destroy]
    get 'customers/my_page'         => "customers#show"
    get 'customers/edit'            => "customers#edit"
    patch 'customers'               => "customers#update"
    get 'customers/unsubscribe'     => "customers#unsubscribe"
    patch 'customers/withdraw'      => "customers#withdraw"
    delete 'cart_items/destroy_all' => "cart_items#destroy_all"
    post 'orders/confirm'           => "orders#confirm"
    get 'orders/conplete'           => "orders#conplete"
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
