class AddUserProfileImage < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_image, :string
    add_column :users, :gravatar_url, :string
  end
end
