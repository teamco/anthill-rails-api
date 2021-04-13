class Website < ApplicationRecord
  mount_base64_uploader :picture, PictureUploader
  belongs_to :user
  has_and_belongs_to_many :widgets, dependent: :destroy
end
