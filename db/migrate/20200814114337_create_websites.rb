class CreateWebsites < ActiveRecord::Migration[6.1]
  def change
    create_table :websites do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.integer :user_id, index: true
      t.integer :version_id
      t.string :key, index: true

      t.timestamps
    end
  end
end
