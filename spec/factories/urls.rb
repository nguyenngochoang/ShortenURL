FactoryBot.define do
  factory :url do
    original_url { "https://google.com" }
    shortened_url { Digest::SHA256.hexdigest(original_url)[0..6] }
    expires_at { Time.now + 4.hours }
  end
end
