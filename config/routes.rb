Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for :admin, slip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
