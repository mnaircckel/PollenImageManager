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
        format.html { redirect_to @index_entry, notice: 'Index entry was successfully created.' }
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
        format.html { redirect_to @index_entry, notice: 'Index entry was successfully updated.' }
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
