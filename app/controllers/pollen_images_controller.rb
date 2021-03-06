class PollenImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_pollen_image, only: [:show, :edit, :update, :destroy]
  
  
  #Search REGEX helper function
  #Matches field with a regexp for whole words
  def search_pollen_images(field)
    @pollen_images.where("upper(#{field}) ~* ? ", "[[:<:]]#{Regexp.escape(params[field.to_sym].upcase)}[[:>:]]")
  end

  # GET /pollen_images
  # GET /pollen_images.json
  def index
    # Order pollen images
    @pollen_images = PollenImage.all.order(:latin_name,:family,:common_name,:grain_number,:focal_plane,:title)
    
    #Search query based on search/simple.html.erb or search/advanced/html.erb 
    #Form passes params[] and redirects to index with params in URL
    #Params[] are matched with pollen_image attributes
    if params[:commit] == "Search"
      # Redirect the user to the search path if all the fields are blank
      if params[:latin_name] == "" and params[:family] == "" and params[:common_name] == ""
        flash[:notice] = "All fields were empty. Please try again."
        redirect_to search_simple_path
      elsif params[:region] == "" and params[:age] == "" and params[:location] == ""
        flash[:notice] = "All fields were empty. Please try again."
        redirect_to search_advanced_path
      end
      
      # Simple search options
      if params[:latin_name] and params[:latin_name] != ""
        @pollen_images = search_pollen_images("latin_name")
      end
      if params[:family] and params[:family] != ""
        @pollen_images = search_pollen_images("family")
      end
      if params[:common_name] and params[:common_name] != ""
        @pollen_images = search_pollen_images("common_name")
      end
      
      # Advanced search options
      if params[:location] and params[:location] != ""
        @pollen_images = search_pollen_images("location")
      end
      if params[:region] and params[:region] != ""
        @pollen_images = search_pollen_images("region")
      end
      if params[:age] and params[:age] != ""
        if params[:age] == "Holocene"
          @pollen_images = @pollen_images.where("age <= 11700 ")
        elsif params[:age] == "Pleistocene"
          @pollen_images = @pollen_images.where("age > 11700 ")
        end
      end
      
      #If pollen images is empty, redirect to search page and inform the user no results were found.
      if @pollen_images.empty?
        flash[:notice] = "No search results found. Please try again."
        redirect_to :back
      end
    end
    
    # Create a list of IDs for ordering so you can traverse images by clicking next and previous
    # The session is the list of all ordered IDs of pollen images
    # Useful because you can call pollen_image_path(id) to go to a image
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
    if session[:ids] # Make sure there is a session of IDs (Generated from index)
      session[:position] = session[:ids].index(@pollen_image.id)
      if session[:position]
        session[:next] = session[:ids][session[:position]+1] || session[:ids].first
        session[:prev] = session[:ids][session[:position]-1] || session[:ids].last
      end
    end
    
  end
  
  def metadata
    @pollen_image = PollenImage.find(params[:pollen_image_id] || params[:id])
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
        format.json { respond_with_bip(@pollen_image) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@pollen_image) }
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
      params.require(:pollen_image).permit(:picture,:picture_cache,:title,:latin_name,:family,:common_name,:region,:age,:location,:notes,:collection,:collection_number,:collector,:place_of_origin,:depth,:grain_number,:focal_plane)
    end
end
