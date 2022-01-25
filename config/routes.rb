Rails.application.routes.draw do
  resources :awesome_lists
  root to: 'technologies#index'
  resources :technologies, only: [:index]
  get '/:technology_name', to: 'technologies#show', as: :technology
end
