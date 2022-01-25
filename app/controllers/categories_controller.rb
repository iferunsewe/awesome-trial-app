class CategoriesController < ApplicationController

  def show
    @technology = Technology.find_by(name: params[:technology_name])
    @category = @technology.categories.find_by(name: params[:category_name])
    
    if @category.nil?
      redirect_back fallback_location: root_path, notice: 'Category not found', status: :not_found
    else
      @repositories ||= @category.repositories
    end
  end
end
