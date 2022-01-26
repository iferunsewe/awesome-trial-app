class RepositoriesController < ApplicationController
  # GET /repositories/new
  def new
  end

  # POST /repositories
  def create
    repository = Repository.find_or_initialize_by_formatted_name(params[:repository])
    category = Category.find_or_initialize_by_formatted_name(params[:category])
    technology = Technology.find_or_initialize_by_formatted_name(params[:technology])

    if technology&.save && category&.update(technology: technology) && repository&.update(category: category)
      redirect_to "/#{technology.name}/#{category.name}", notice: 'Repository was successfully created.'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to create repository'
    end
  end
end
