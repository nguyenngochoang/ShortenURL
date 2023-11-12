class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    build_resource(sign_up_params)

    resource.password = Devise.friendly_token
    resource.password_confirmation = resource.password
    resource.authentication_token = SecureRandom.hex(8)
    if resource.save
      UserMailer.registration_confirmation(resource).deliver_now
      @notice = "Success! Please check your email inbox"
    else
      clean_up_passwords resource
      @notice = "Failed! #{resource.errors.full_messages.first}"
    end
    respond_with resource, location: after_sign_up_path_for(resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email)
  end
end
