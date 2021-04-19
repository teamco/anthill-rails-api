# frozen_string_literal: true

## API
module Api
  ## V1
  module V1
    ## UsersController
    class UsersController < ApiController
      before_action :current_user

      def fetch
        @user = nil if @user.force_sign_out? && @user.signed_in?
        handle_error(@user, 'user', 'prepare_json')
      end

      def all_users
        handle_error(@user, 'users', 'all_prepare_json')
      end

      def fetch_user
        if @user
          user = @user.self_or_user(:key, params[:key], 'find_by_key')
          handle_error(user, 'user', 'prepare_json')
        else
          render_error(@user)
        end
      end

      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        if @user
          user = @user.self_or_user(:key, params[:key], 'find_by_key')
          if user&.update(user_params)
            handle_error(user, 'user', 'prepare_json')
          else
            render_error(user)
          end
        else
          render_error(@user)
        end
      end

      def logout(extra = { force_sign_out: false })
        if @user
          user = @user.self_or_user(:key, params[:key], 'find_by_key')
          if (extra[:force_sign_out] && @user.superadmin_role?) || @user.id == user.id
            handle_sign_out(user, extra)
          else
            render_error(user)
          end
        else
          render_error(@user)
        end
      end

      def force_logout
        logout({ force_sign_out: true })
      end

      private

      def handle_sign_out(user, extra = {})
        sign_out(user)
        user.update({ signed_in: false }.merge(extra))
        handle_error(user, 'user', 'prepare_json')
      end

      def handle_error(instance, key, method)
        if instance.nil?
          render_error(instance)
        else
          render json: Hash[key, instance.send(method)]
        end
      end

      def render_error(instance)
        errors = instance.nil? ? 'Record not found' : instance.errors
        render json: { errors: errors, status: :unprocessable_entity }
      end

      def current_user
        token = request.headers.fetch('Authorization', '').split(' ').last
        payload = JsonWebToken.decode(token)
        @user = User.find(payload['sub'])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :key, :profile_image,
                                     :remove_profile_image, :force_sign_out,
                                     :signed_in)
      end
    end
  end
end
