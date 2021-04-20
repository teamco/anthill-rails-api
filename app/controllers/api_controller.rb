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
end
