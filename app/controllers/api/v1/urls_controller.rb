module Api
  module V1
    class UrlsController < Api::BaseController
      before_action :authenticate_user!

      def create
        @url = ::Api::V1::ShortenUrlService.call(original_url: params[:original_url])
        if @url.persisted?
          render json: @url, api_link: request.url
        else
          render json: { errors: @url.errors.messages }
        end
      end

      private

      def authenticate_user!
        user = User.find_by(email: request.headers["X-User-Email"], authentication_token: request.headers["X-User-Token"])
        render_unauthorized_response if user.nil?
      end
    end
  end
end
