class TechnologiesController < ApplicationController
  
  # GET /
  def index
    @technologies ||= Technology.all
  end

  # GET /<technology_name>
  def show
    @technology ||= Technology.find_by(name: params[:technology_name])

    if @technology.nil?
      redirect_to technologies_path, notice: 'Technology not found'
    else
      @categories ||= @technology.categories
    end
  end

end
