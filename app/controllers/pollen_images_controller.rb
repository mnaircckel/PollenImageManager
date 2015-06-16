class PollenImagesController < ApplicationController
  before_action :set_pollen_image, only: [:show, :edit, :update, :destroy]

  # GET /pollen_images
  # GET /pollen_images.json
  def index
    @pollen_images = PollenImage.all
  end

  # GET /pollen_images/1
  # GET /pollen_images/1.json
  def show
  end

  # GET /pollen_images/new
  def new
    @pollen_image = PollenImage.new
  end

  # GET /pollen_images/1/edit
  def edit
  end

  # POST /pollen_images
  # POST /pollen_images.json
  def create
    @pollen_image = PollenImage.new(pollen_image_params)

    respond_to do |format|
      if @pollen_image.save
        format.html { redirect_to @pollen_image, notice: 'Pollen image was successfully created.' }
        format.json { render :show, status: :created, location: @pollen_image }
      else
        format.html { render :new }
        format.json { render json: @pollen_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollen_images/1
  # PATCH/PUT /pollen_images/1.json
  def update
    respond_to do |format|
      if @pollen_image.update(pollen_image_params)
        format.html { redirect_to @pollen_image, notice: 'Pollen image was successfully updated.' }
        format.json { render :show, status: :ok, location: @pollen_image }
      else
        format.html { render :edit }
        format.json { render json: @pollen_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollen_images/1
  # DELETE /pollen_images/1.json
  def destroy
    @pollen_image.destroy
    respond_to do |format|
      format.html { redirect_to pollen_images_url, notice: 'Pollen image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pollen_image
      @pollen_image = PollenImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pollen_image_params
      params.require(:pollen_image).permit(:tags,:name,:title)
    end
end
