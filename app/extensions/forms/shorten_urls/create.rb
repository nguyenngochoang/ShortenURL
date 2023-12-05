module Forms
  module ShortenUrls
    class Create
      include ActiveModel::Model

      validates_presence_of :original_url, :shortened_url, :expires_at
      validate :shortened_url_uniqness
      validates :original_url, format: { with: URI::regexp(%w(http https)), message: "Valid URL required"}

      def initialize(original_url:)
        @original_url = original_url
        @expires_at = Time.now + 8.hours

        shorten_url
      end

      def shorten_url
        @shortened_url = Digest::SHA256.hexdigest(original_url)[0..6] if original_url

        @url = Url.new(
          original_url:,
          shortened_url:,
          expires_at:
        )
      end

      def shortened_url_uniqness
        errors.add(:base, :existed) if Url.find_by(shortened_url: shortened_url).present?
      end

      attr_reader :original_url, :shortened_url, :expires_at, :url
    end
  end
end
