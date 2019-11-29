Rails.application.routes.draw do
  devise_for :users
  root 'videos#index'

  resources :videos, only: [:index, :show] do
    post "view", on: :member
  end
end
