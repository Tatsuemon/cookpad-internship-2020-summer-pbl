Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'gachas#index'
  resources :gachas, only: [:create]
  resources :recipes, only: [:index, :show]
  resources :ingredients, only: [:index]

  post '/ingredients/checked' => "ingredients#check"
end
