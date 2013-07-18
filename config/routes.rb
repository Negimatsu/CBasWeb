CBasWebRVM::Application.routes.draw do
  get "contact/index"

  get "manual/manual"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end