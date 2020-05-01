Rails.application.routes.draw do
  root :to => 'messages#index'

  resources :messages, only: %i[new show index create]
  resources :payment, only: :create
end
