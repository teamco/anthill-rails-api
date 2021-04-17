class AddUserKey < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :key, :string
  end
end
