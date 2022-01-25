class TechnologiesController < ApplicationController
  
  # GET /technologies
  def index
    @technologies ||= Technology.all
  end

  # GET /technologies/1
  def show
    @technology ||= Technology.find_by(name: params[:technology_name])

    if @technology.nil?
      redirect_to technologies_path, notice: 'Technology not found', status: :not_found
    else
      @categories ||= @technology.categories
    end
  end

end
