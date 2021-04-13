class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.text :key, index: true
      t.integer :width, default: 300
      t.integer :height, default: 300
      t.string :resource
      t.string :picture
      t.boolean :is_external, default: false
      t.string :external_resource
      t.boolean :visible, default: true
      t.boolean :public, default: false
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
