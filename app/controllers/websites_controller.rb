class WebsitesController < ApplicationController
  before_action :set_website, only: %i[show edit update assigned_widgets assign_widgets destroy]
  before_action :set_assigned_widgets, only: %i[assigned_widgets]

  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.all
  end

  # GET /websites/1
  # GET /websites/1.json
  def show; end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit; end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET
  def assigned_widgets; end

  # POST
  def assign_widgets
    @widgets = Widget.where({key: widgets_params[:widget_ids]})
    @website.widgets = []
    @website.widgets << @widgets
    respond_to do |format|
      if @website.save
        set_assigned_widgets
        format.json { render :assigned_widgets, status: :created, location: @website }
      else
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_website
    @website = Website.find_by_key(params[:id])
  end

  def set_assigned_widgets
    @assigned_widgets = @website.widgets
  end

  # Only allow a list of trusted parameters through.
  def website_params
    params.require(:website).permit(:name, :description, :picture,
        :user_id, :version_id, :key, :tags, widget_ids: [])
  end

  def widgets_params
    params.require(:website).permit(:user_id, :key, widget_ids: [])
  end
end
