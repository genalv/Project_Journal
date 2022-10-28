Rails.application.routes.draw do

  devise_for :users
  
  root "categories#index"

  get "/today", to: "tasks#due_today"

  resources :categories do
    resources :tasks
  end
end
