# frozen_string_literal: true

module Api
  module V1
    ## AuthenticationController
    class AuthenticationController < ApiController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          render json: { token: JsonWebToken.encode(sub: user.id) }
        else
          render json: { errors: 'Invalid authorization credentials' }
        end
      end

      def fetch
        render json: current_user
      end
    end
  end
end
