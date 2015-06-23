class PollenImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_pollen_image, only: [:show, :edit, :update, :destroy]

  # GET /pollen_images
  # GET /pollen_images.json
  def index
    # Order pollen images
    @pollen_images = PollenImage.all.order(:latin_name,:family,:common_name,:title)
    
    #Search query based on searc/simple.html.erb form which passes params[] and redirects to index
    if params[:commit] == "Search"
      if params[:title] != ""
        @pollen_images = @pollen_images.where("upper(title) = ? ", "#{params[:title].upcase}")
      end
      if params[:latin_name] != ""
        @pollen_images = @pollen_images.where("upper(latin_name) = ? ", "#{params[:latin_name].upcase}")
      end
      if params[:family] != ""
        @pollen_images = @pollen_images.where("upper(family) = ? ", "#{params[:family].upcase}")
      end
      if params[:common_name] != ""
        @pollen_images = @pollen_images.where("upper(common_name) = ? ", "#{params[:common_name].upcase}")
      end
    end
    
    # Create a list of IDs for ordering so you can traverse images by clicking next and previous
    session[:ids] = []
    for pollen in @pollen_images do
      session[:ids].push(pollen.id)
    end
    
    # Paginate the images
    @pollen_images = @pollen_images.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /pollen_images/1
  # GET /pollen_images/1.json
  def show
    # Index the current image ID based on the ordering, and find the ID for the next and previous image
    if session[:ids] # Make sure there is a session of IDS (Generated from index)
      session[:position] = session[:ids].index(@pollen_image.id)
      session[:next] = session[:ids][session[:position]+1] || session[:ids].first
      session[:prev] = session[:ids][session[:position]-1] || session[:ids].last
    end
    
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
      params.require(:pollen_image).permit(:title,:image,:latin_name,:family,:common_name)
    end
end
