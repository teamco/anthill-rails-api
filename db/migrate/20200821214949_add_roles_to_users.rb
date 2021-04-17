class AddRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :superadmin_role, :boolean, default: false
    add_column :users, :supervisor_role, :boolean, default: false
    add_column :users, :user_role, :boolean, default: true

    User.first.update(superadmin_role: true, user_role: false)
  end
end
