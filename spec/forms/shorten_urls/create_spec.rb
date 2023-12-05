require 'rails_helper'

RSpec.describe Forms::ShortenUrls::Create, type: :form do
  context 'when initialized with a valid original url' do
    let(:original_url) { 'https://www.google.com' }
    subject { described_class.new(original_url: original_url) }

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'has a shortened url' do
      expect(subject.shortened_url).to be_present
    end

    it 'has an expires at' do
      expect(subject.expires_at).to be_present
    end

    it 'has a url object' do
      expect(subject.url).to be_a(Url)
    end
  end

  context 'when initialized with an invalid original url' do
    let(:original_url) { 'invalid url' }
    subject { described_class.new(original_url: original_url) }

    it 'is invalid' do
      expect(subject).to be_invalid
    end

    it 'has an error on original url' do
      subject.valid?
      expect(subject.errors[:original_url]).to include('Valid URL required')
    end
  end
end
