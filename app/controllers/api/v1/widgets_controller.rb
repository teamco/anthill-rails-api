# frozen_string_literal: true

## API
module Api
  ## V1
  module V1
    ## WidgetsController
    class WidgetsController < ApiController
      before_action :current_user
      before_action :set_user
      before_action :set_widget, only: %i[show edit update destroy_file assigned_widgets destroy]

      # GET /widgets
      # GET /widgets.json
      def index
        @widgets = @widget_user.widgets
        render json: { widgets: @widgets }
      end

      # GET /widgets/1
      # GET /widgets/1.json
      def show; end

      # GET /widgets/new
      def new
        @widget = Widget.new
      end

      # GET /widgets/1/edit
      def edit; end

      # POST /widgets
      # POST /widgets.json
      def create
        @widget = Widget.new(widget_params)

        respond_to do |format|
          if @widget.save
            format.html { redirect_to @widget, notice: 'Widget was successfully created.' }
            format.json { render :show, status: :created, location: @widget }
          else
            format.html { render :new }
            format.json { render json: @widget.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /widgets/1
      # PATCH/PUT /widgets/1.json
      def update
        respond_to do |format|
          if @widget.update(widget_params)
            format.html { redirect_to @widget, notice: 'Widget was successfully updated.' }
            format.json { render :show, status: :ok, location: @widget }
          else
            format.html { render :edit }
            format.json { render json: @widget.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /widgets/1
      # DELETE /widgets/1.json
      def destroy
        @widget.destroy
        respond_to do |format|
          format.html { redirect_to widgets_url, notice: 'Widget was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private

      def set_user
        @widget_user = @user.self_or_user(:key, params[:user_key], 'find_by_key')
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_widget
        @widget = @widget_user.widgets.where({ key: params[:widget_key] }).first
        render_error(@widget) if @widget.nil?
      end

      # Only allow a list of trusted parameters through.
      def widget_params
        params.require(:widget).permit(:name, :description, :picture, :key,
                                       :user_id, :width, :height, :tags,
                                       :remove_picture)
      end
    end
  end
end
