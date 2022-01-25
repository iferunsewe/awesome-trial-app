Rails.application.routes.draw do
  resources :awesome_lists
  root to: 'technologies#index'
  resources :technologies, only: [:index]
  get '/:technology_name', to: 'technologies#show', as: :technology
  get '/:technology_name/:category_name', to: 'categories#show', as: :category
end
