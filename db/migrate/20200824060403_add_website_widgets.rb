class AddWebsiteWidgets < ActiveRecord::Migration[6.1]
  def change
    create_table :website_widgets, force: true do |t|
      t.integer :website_id, index: true
      t.integer :widget_id, index: true
      t.integer :user_id, index: true
      t.timestamps
    end
  end
end
