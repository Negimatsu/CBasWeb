CBasWebRVM::Application.routes.draw do

  get "process/finish"
  get "process/going"
  get "process/done"
  get "process/fail"

  get "program/new"
  get "program/create"

  match "manual" =>"static#document"
  match "contact" => "static#contact"
  match "program" =>"work#new"
  get "profile/:id" , to: 'users#show' ,as: 'profile'

  authenticated :user do
    root :to => 'home#index'
  end

  scope 'admin'do
      match "list_work" => "admin#list_work"
    end

  root :to => "home#index"
  devise_for :users
  resources :users
  resources :work
end