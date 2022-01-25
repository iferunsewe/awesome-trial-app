class RepositoriesController < ApplicationController
  def new
  end

  def create
    repository = Repository.find_or_initialize_by(name: params[:repository])
    category = Category.find_or_initialize_by(name: params[:category])
    technology = Technology.find_or_initialize_by(name: params[:technology])

    if technology.save && category.update(technology: technology) && repository.update(category: category)
      redirect_to "/#{technology.name}/#{category.name}", notice: 'Repository was successfully created.'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to create repository'
    end
  end
end
