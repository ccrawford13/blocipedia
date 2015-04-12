Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :index] do
    post 'downgrade_account' => 'users#downgrade_account', as: :downgrade_account
  end
  resources :wikis
  resources :charges, only: [:new, :create]
  

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  
end
