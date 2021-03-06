class IndexEntriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_index_entry, only: [:show, :edit, :update, :destroy]

  # GET /index_entries
  # GET /index_entries.json
  def index
    @index_entries = IndexEntry.all.order(:latin_name,:family,:common_name)
  end

  # GET /index_entries/1
  # GET /index_entries/1.json
  def show
    # The show method for the index is used to direct the user to the first pollen image
    # This is done by first sorting the Pollen Images by Latin Name
    # Then the pollen image's latin name is checked against the index's latin name
    # Finally a session is generated (See pollen_images_controller.rb for more info) so the user can browse multiple images
    # and the usser is redirected to the first pollen image in the list (if one exists)
    @pollen_images = PollenImage.all.order(:latin_name,:family,:common_name,:title)
    @selected_images = @pollen_images.select{|pollen| pollen.latin_name.upcase == @index_entry.latin_name.upcase}
    if @selected_images and @selected_images != []
      session[:ids] = []
      for pollen in @selected_images do
        session[:ids].push(pollen.id)
      end
      @pollen_image_id = @selected_images.first.id
      redirect_to pollen_image_path(@pollen_image_id)
    else
      flash[:notice] = "No entries found!"
      redirect_to index_entries_path
    end
  end

  # GET /index_entries/new
  def new
    @index_entry = IndexEntry.new
  end

  # GET /index_entries/1/edit
  def edit
  end

  # POST /index_entries
  # POST /index_entries.json
  def create
    @index_entry = IndexEntry.new(index_entry_params)

    respond_to do |format|
      if @index_entry.save
        format.html { redirect_to index_entries_url, notice: 'Index entry was successfully created.' }
        format.json { render :show, status: :created, location: @index_entry }
      else
        format.html { render :new }
        format.json { render json: @index_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index_entries/1
  # PATCH/PUT /index_entries/1.json
  def update
    respond_to do |format|
      if @index_entry.update(index_entry_params)
        format.html { redirect_to index_entries_url, notice: 'Index entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @index_entry }
      else
        format.html { render :edit }
        format.json { render json: @index_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index_entries/1
  # DELETE /index_entries/1.json
  def destroy
    @index_entry.destroy
    respond_to do |format|
      format.html { redirect_to index_entries_url, notice: 'Index entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_entry
      @index_entry = IndexEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_entry_params
      params.require(:index_entry).permit(:latin_name, :family, :common_name)
    end
end
