FactoryBot.define do
  factory :user do
    email { "test@test.com" }
    password { "foobarbaz" }
    authentication_token { Devise.friendly_token }
  end
end
