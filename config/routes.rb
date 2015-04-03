Rails.application.routes.draw do

  get 'users/index'

  get 'users/show'

  get 'users/update'

  devise_for :users
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  
end
