# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Shortener service!'
  end
end
