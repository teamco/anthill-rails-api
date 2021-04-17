# frozen_string_literal: true

## User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  mount_base64_uploader :profile_image, PictureUploader

  def generate_jwt
    JWT.encode({ id: id, exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  def self_or_user(entity_key, entity_value, method = 'find', instance_value = nil)
    instance_value = id if entity_key == :id
    instance_value = key if entity_key == :key
    return nil if instance_value.nil?

    condition = instance_value == entity_value
    if superadmin_role?
      User.send(method, instance_value) if condition
    elsif condition
      User.send(method, instance_value)
    end
  end

  def all_prepare_json
    if superadmin_role?
      User.all.map(&:prepare_json)
    else
      [prepare_json]
    end

  end

  def prepare_json
    {
      id: id,
      provider: provider,
      metadata: profile.merge({ key: key }, timestamp, roles, monitor)
    }
  end

  private

  def timestamp
    {
      timestamp: {
        created_at: created_at,
        updated_at: updated_at
      }
    }
  end

  def profile
    {
      profile: {
        email: email,
        name: name,
        profile_image: profile_image,
        gravatar_url: gravatar_url
      }
    }
  end

  def roles
    {
      roles: {
        superadmin_role: superadmin_role,
        supervisor_role: supervisor_role
      }
    }
  end

  def monitor
    {
      trackable: {
        sign_in_count: sign_in_count,
        current_sign_in_at: current_sign_in_at,
        last_sign_in_at: last_sign_in_at,
        current_sign_in_ip: current_sign_in_ip,
        last_sign_in_ip: last_sign_in_ip
      }
    }
  end
end
