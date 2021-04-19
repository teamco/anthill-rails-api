class AddUserLoggedInStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :signed_in, :boolean, default: false
    add_column :users, :force_sign_out, :boolean, default: false
  end
end
