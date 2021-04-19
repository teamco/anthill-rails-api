# frozen_string_literal: true

module Api
  module V1
    ## AuthenticationController
    class AuthenticationController < ApiController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          user.update({ signed_in: true, force_sign_out: false })
          render json: { token: JsonWebToken.encode(sub: user.id) }
        else
          render json: {
            errors: 'Invalid authorization credentials',
            status: :forbidden
          }
        end
      end

      private

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :key, :profile_image,
                                     :remove_profile_image, :logged_in)
      end
    end
  end
end
