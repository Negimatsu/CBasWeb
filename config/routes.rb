CBasWebRVM::Application.routes.draw do

  match "manual" =>"static#manual"
  match "contact" => "static#contact"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end