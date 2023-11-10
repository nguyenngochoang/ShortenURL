module Api
  module V1
    class ShortenUrlService < ::ApplicationService
      def self.call(original_url:)
        new(original_url:).shorten
      end

      def initialize(original_url:)
        @original_url = original_url
        @shortened_url = Digest::SHA256.hexdigest(original_url)[0..6]
      end

      def shorten
        Url.create(
          original_url:,
          shortened_url:,
          expires_at: Time.now + 4.hours
        )
      end

      private

      attr_reader :original_url, :shortened_url
    end
  end
end