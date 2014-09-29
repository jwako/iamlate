Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users
  resource :home, controller: :home, only: [:show, :create]

end
