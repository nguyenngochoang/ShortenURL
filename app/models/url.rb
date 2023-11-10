require 'digest'

class Url < ApplicationRecord
  validates :original_url, presence: true, format: URI::regexp(%w[http https])
  validates :shortened_url, presence: true, uniqueness: true

  def self.find_original(shortened_url)
    url = Url.find_by(shortened_url: shortened_url)
    url.original_url if url
  end
end
