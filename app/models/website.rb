# frozen_string_literal: true

## Website
class Website < ApplicationRecord
  mount_base64_uploader :picture, PictureUploader

  belongs_to :user
  has_and_belongs_to_many :widgets, dependent: :destroy

  def self_or_website(user, entity_key, entity_value, method = 'find', instance_value = nil)
    instance_value = id if entity_key == :id
    instance_value = key if entity_key == :key
    return nil if instance_value.nil?

    condition = instance_value == entity_value
    if user.superadmin_role?
      Website.send(method, entity_value)
    elsif condition
      Website.send(method, instance_value)
    end
  end

end
