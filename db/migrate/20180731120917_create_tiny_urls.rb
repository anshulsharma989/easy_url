class CreateTinyUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :tiny_urls do |t|
      t.string :orginal_url
      t.string :generated_url
      t.text :system_info

      t.timestamps
    end
  end
end
