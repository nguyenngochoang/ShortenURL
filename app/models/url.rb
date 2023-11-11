require 'digest'

class Url < ApplicationRecord
  validates :original_url, presence: true, format: URI::regexp(%w[http https])
  validates :shortened_url, presence: true, uniqueness: true
  validates :expires_at, presence: true

  scope :expired, -> {where(expires_at: ...Time.now)}

  def expired?
    expires_at < Time.now
  end
end
