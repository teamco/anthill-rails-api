class AddTags < ActiveRecord::Migration[6.1]
  def change
    add_column :websites, :tags, :string
    add_column :widgets, :tags, :string
  end
end
