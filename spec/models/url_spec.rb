require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:valid_attributes) do
    {
      original_url: 'https://example.com',
      shortened_url: 'abc123',
      expires_at: Time.now + 4.hours
    }
  end

  it 'is valid when using valid attributes' do
    url = build_stubbed(:url, **valid_attributes)
    expect(url).to be_valid
  end

  it 'is invalid without an original_url' do
    url = build_stubbed(:url, **valid_attributes.merge(original_url: nil))
    expect(url).to_not be_valid
  end

  it 'is invalid without a valid original_url' do
    url = build_stubbed(:url, **valid_attributes.merge(original_url: 'invalid_url'))
    expect(url).to_not be_valid
  end

  it 'is invalid without a shortened_url' do
    url = build_stubbed(:url, **valid_attributes.merge(shortened_url: nil))
    expect(url).to_not be_valid
  end

  it 'is invalid without expires_at' do
    url = build_stubbed(:url, **valid_attributes.merge(expires_at: nil))
    expect(url).to_not be_valid
  end

  describe 'scopes' do
    it 'includes expired URLs' do
      expired_url = create(:url, expires_at: Time.now - 1.day)
      expect(Url.expired).to include(expired_url)
    end

    it 'excludes non-expired URLs' do
      non_expired_url = create(:url, expires_at: Time.now + 1.day)
      expect(Url.expired).to_not include(non_expired_url)
    end
  end

  describe '#expired?' do
    it 'returns true if the URL is expired' do
      url = build_stubbed(:url, expires_at: Time.now - 1.day)
      expect(url.expired?).to be true
    end

    it 'returns false if the URL is not expired' do
      url = build_stubbed(:url, expires_at: Time.now + 1.day)
      expect(url.expired?).to be false
    end
  end
end
