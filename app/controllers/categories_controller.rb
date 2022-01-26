class CategoriesController < ApplicationController
  # GET /<technology_name>/<category_name>
  def show
    @technology = Technology.find_by_formatted_name(params[:technology_name])
    @category = @technology&.categories&.find_by_formatted_name(params[:category_name])
    
    if @category.nil?
      redirect_back fallback_location: root_path, notice: 'Category not found'
    else
      @repositories ||= @category.repositories
    end
  end
end
