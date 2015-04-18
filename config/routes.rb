Rails.application.routes.draw do
  
  root "projects#index"
  
  namespace :admin do
    root "base#index"
  end

  resources :projects do
    resources :tickets
  end
  
  devise_for :users
  
end

