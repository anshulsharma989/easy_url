class CreateTinyUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :tiny_urls do |t|


      t.timestamps
    end
  end
end
