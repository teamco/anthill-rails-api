## API
module Api
  ## V1
  module V1
    ## UsersController
    class UsersController < ApiController
      def current_user
        token = request.headers.fetch('Authorization', '').split(' ').last
        payload = JsonWebToken.decode(token)
        user = User.find(payload['sub'])
        if user
          render json: { user: user }
        else
          render json: { errors: 'Invalid token' }
        end
      end
    end
  end
end
