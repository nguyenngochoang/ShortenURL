module Api
  module V1
    class UrlsController < ApplicationController
      before_action :authenticate_user!, only: :need_authentication_actions
      API_PATH = "/api/v1/urls/"

      def create
        @url = ::Api::V1::ShortenUrlService.call(original_url: params[:original_url])
        render json: @url, api_link: request.url, host: request.base_url + API_PATH
      end

      def show
        original_url = Url.find_original(params[:shortened_url])
        if original_url
          redirect_to original_url, allow_other_host: true
        else
          render json: { error: 'URL not found' }, status: :not_found
        end
      end

      private

      def need_authentication_actions
        %i[create]
      end

      def authenticate_user!
        user = User.find_by(email: request.headers["X-User-Email"], authentication_token: request.headers["X-User-Token"])

        render_unauthorized_response if user.nil?
      end
    end
  end
end
