module Api
  module V1
    class ShortenUrlService < ::ApplicationService
      def self.call(original_url:)
        new(original_url:).shorten
      end

      def initialize(original_url:)
        @original_url = original_url
      end

      def shorten
        url = Url.find_by(original_url:)
        return {url: url} if url.present?

        form = Forms::ShortenUrls::Create.new(original_url:)
        if form.valid?
          form.url.save
          { url: form.url.reload, errors: [] }
        else
          { errors: form.errors.full_messages }
        end
      end

      private

      attr_reader :original_url
    end
  end
end
