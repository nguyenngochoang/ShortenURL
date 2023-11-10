class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, only: :need_authentication_actions

  private

  def render_unauthorized_response
    render json: {status: "error", message: "Unauthorized"}, status: :unauthorized
  end
end
