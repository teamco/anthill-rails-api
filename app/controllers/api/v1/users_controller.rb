# frozen_string_literal: true

## API
module Api
  ## V1
  module V1
    ## UsersController
    class UsersController < ApiController
      before_action :current_user
      before_action :set_user, only: %i[fetch_user update logout destroy]

      def fetch
        @user = nil if @user&.force_sign_out? && @user&.signed_in?
        handle_error(@user, 'user', 'prepare_json')
      end

      def all_users
        handle_error(@user, 'users', 'all_prepare_json')
      end

      def fetch_user
        handle_error(@selected_user, 'user', 'prepare_json')
      end

      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        if @selected_user&.update(user_params)
          handle_error(@selected_user, 'user', 'prepare_json')
        else
          render_error(@selected_user)
        end
      end

      def logout(extra = { force_sign_out: false })
        if (extra[:force_sign_out] && @user&.superadmin_role?) || @user&.id == @selected_user&.id
          handle_sign_out(@selected_user, extra)
        else
          render_error(@selected_user)
        end
      end

      def force_logout
        logout({ force_sign_out: true })
      end

      # DELETE /websites/1
      # DELETE /websites/1.json
      def destroy
        if @selected_user.nil?
          render_error(@selected_user)
        else
          @selected_user.destroy
          render json: { head: :no_content }
        end
      end

      private

      def set_user
        @selected_user = @user&.self_or_user(:key, params[:user_key], 'find_by_key')
      end

      def handle_sign_out(user, extra = {})
        sign_out(user)
        user&.update({ signed_in: false }.merge(extra))
        handle_error(user, 'user', 'prepare_json')
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :key, :user_key,
                                     :profile_image, :remove_profile_image,
                                     :force_sign_out, :signed_in)
      end
    end
  end
end
