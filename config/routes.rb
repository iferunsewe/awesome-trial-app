Rails.application.routes.draw do
  root to: 'technologies#index'
  resources :technologies, only: [:index]
  resources :repositories, only: [:show, :new, :create]
  get '/:technology_name', to: 'technologies#show', constraint: lambda { |req| Technology.exists?(name: req.params[:technology_name]) }
  get '/:technology_name/:category_name', to: 'categories#show', constraint: lambda { |req|
    technology = Technology.find_by(name: req.params[:technology_name])
    technology&.categories.exists?(name: req.params[:category_name])
  }
  get '/:technology_name/:category_name/:repository_name', to: 'repositories#show', constraint: lambda { |req|
    technology = Technology.find_by(name: req.params[:technology_name])
    category = technology&.categories.find_by(name: req.params[:category_name])
    category&.repositories.exists?(name: req.params[:repository_name])
  }
end
