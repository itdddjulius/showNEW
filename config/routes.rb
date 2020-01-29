Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }
  resources :widgets
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'widgets#index'
  post '/search' => 'widgets#search'
  get '/delete_widget/:id' => 'widgets#destroy', as: :delete_widget
  get '/my_widgets' => 'widgets#my_widget', as: :my_widget
end
