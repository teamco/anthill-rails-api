# frozen_string_literal: true

## API
module Api
  ## V1
  module V1
    ## WebsitesController
    class WebsitesController < ApiController

      before_action :set_website, only: %i[show edit update assigned_widgets assign_widgets destroy]
      before_action :set_assigned_widgets, only: %i[assigned_widgets]

      # GET /websites
      # GET /websites.json
      def index
        @websites = Website.all
        render json: { websites: @websites }
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

        if @website.save
          render json: { status: :created, location: @website }
        else
          render json: { errors: @website.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /websites/1
    # PATCH/PUT /websites/1.json
    def update
      if @website.update(website_params)
        render json: { status: :ok, location: @website }
      else
        render json: { errors: @website.errors, status: :unprocessable_entity }
      end
    end

    # GET
    def assigned_widgets; end

    # POST
    def assign_widgets
      @widgets = Widget.where({ key: widgets_params[:widget_ids] })
      @website.widgets = []
      @website.widgets << @widgets

      if @website.save
        set_assigned_widgets
        render json: { status: :created, location: @website }
      else
        render json: { errors: @website.errors, status: :unprocessable_entity }
      end
    end

    # DELETE /websites/1
    # DELETE /websites/1.json
    def destroy
      @website.destroy
      render json: { head: :no_content }
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
                                      :user_id, :version_id, :key,
                                      :tags, widget_ids: [])
    end

    def widgets_params
      params.require(:website).permit(:user_id, :key, widget_ids: [])
    end
  end
end