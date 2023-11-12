module Api
  module V1
    class UrlsController < Api::BaseController
      before_action :authenticate_user!

      def create
        @url = ::Api::V1::ShortenUrlService.call(original_url: params[:original_url])

        if @url.persisted?
          render json: @url, api_link: request.url, timezone: @user.timezone, code: 200
        else
          render json: {
            code: 422,
            errors: @url.errors.full_messages
          }, status: :unprocessable_entity
        end
      rescue => e
        render json: {
          code: 500,
          errors: e.message
        }, status: :unprocessable_entity
      end

      private

      def authenticate_user!
        @user = User.find_by(email: request.headers["X-User-Email"], authentication_token: request.headers["X-User-Token"])
        render_unauthorized_response if @user.nil?
      end
    end
  end
end
