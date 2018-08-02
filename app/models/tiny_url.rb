class TinyUrl < ApplicationRecord
  validates :orginal_url, :format => URI::regexp(%w(http https))
end
