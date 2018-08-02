class AddCoulmnLastHitTimeToTinyUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :tiny_urls, :last_hit, :datetime
    change_column :tiny_urls, :orginal_url, :text
  end
end
