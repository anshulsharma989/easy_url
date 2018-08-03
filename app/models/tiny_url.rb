class TinyUrl < ApplicationRecord
  include Decodable
  validates :orginal_url, :format => URI::regexp(%w(http https))
  after_create :set_decode_url

  def set_last_hit
    self.last_hit = Time.now.strftime("%d/%m/%Y %H:%M")
    self.save
  end

  def set_decode_url
    self.generated_url = genrate_short_url(self.id)
    self.save
  end

  def self.get_tiny_url_by_path(path_after_base_url)
    coded_url = get_decoded_url(path_after_base_url)
    url_id = get_url_id(coded_url)
    self.find(url_id)
  end
end
