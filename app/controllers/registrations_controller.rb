# frozen_string_literal: true

require 'rb-gravatar'

## RegistrationsController
class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(sign_up_params)
    @user.gravatar_url = Gravatar.src(@user.email)

    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :gravatar_url)
  end
end
