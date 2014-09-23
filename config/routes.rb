Rails.application.routes.draw do
  root to: 'visitors#index'
  resource :home, controller: :home, only: [:show, :create]
  devise_for :users

end
