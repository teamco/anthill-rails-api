class AddSocialToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string

    # Initialize first account:
    User.create! do |u|
      u.email = 'admin@admin.com'
      u.password = '12345678'
    end
  end
end
