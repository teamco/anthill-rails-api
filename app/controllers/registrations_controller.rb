# frozen_string_literal: true

require 'rb-gravatar'

## RegistrationsController
class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(sign_up_params)
    @user.gravatar_url = Gravatar.src(@user.email)
    @user.provider = 'password'
    user = User.find_by_email(params[:email])

    if user.nil?
      if @user.save
        render json: { user: @user }
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Email already exist' }, status: :conflict
    end
  end

  private

  def sign_up_params
    params.permit(:name, :key, :email, :password, :password_confirmation, :gravatar_url)
  end
end
