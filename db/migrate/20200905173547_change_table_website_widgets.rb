class ChangeTableWebsiteWidgets < ActiveRecord::Migration[6.1]
  def change
    rename_table :website_widgets, :websites_widgets
  end
end
