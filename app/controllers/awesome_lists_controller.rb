class AwesomeListsController < ApplicationController
  before_action :set_awesome_list, only: %i[ show edit update destroy ]

  # GET /awesome_lists or /awesome_lists.json
  def index
    @awesome_lists = AwesomeList.all
  end

  # GET /awesome_lists/1 or /awesome_lists/1.json
  def show
  end

  # GET /awesome_lists/new
  def new
    @awesome_list = AwesomeList.new
  end

  # GET /awesome_lists/1/edit
  def edit
  end

  # POST /awesome_lists or /awesome_lists.json
  def create
    @awesome_list = AwesomeList.new(awesome_list_params)

    respond_to do |format|
      if @awesome_list.save
        format.html { redirect_to awesome_list_url(@awesome_list), notice: "Awesome list was successfully created." }
        format.json { render :show, status: :created, location: @awesome_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @awesome_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awesome_lists/1 or /awesome_lists/1.json
  def update
    respond_to do |format|
      if @awesome_list.update(awesome_list_params)
        format.html { redirect_to awesome_list_url(@awesome_list), notice: "Awesome list was successfully updated." }
        format.json { render :show, status: :ok, location: @awesome_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @awesome_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awesome_lists/1 or /awesome_lists/1.json
  def destroy
    @awesome_list.destroy

    respond_to do |format|
      format.html { redirect_to awesome_lists_url, notice: "Awesome list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_awesome_list
      @awesome_list = AwesomeList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def awesome_list_params
      params.require(:awesome_list).permit(:technology, :category, :repository)
    end
end
