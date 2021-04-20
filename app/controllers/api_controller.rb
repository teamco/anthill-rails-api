# frozen_string_literal: true

## API Controller class
class ApiController < ApplicationController
  before_action :set_default_format
  before_action :authenticate_user!

  private

  def set_default_format
    request.format = :json
  end

  def current_user
    token = request.headers.fetch('Authorization', '').split(' ').last
    payload = JsonWebToken.decode(token)
    @user = User.find(payload['sub'])
    return unless @user.nil?

    render_error(@user)
    raise StandardError, 'Record not found'
  end
end
