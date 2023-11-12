# spec/controllers/api/v1/urls_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :request do
  let(:user) { create(:user) }
  let(:headers) {
    {
      "X-User-Email": user.email,
      "X-User-Token": user.authentication_token,
      "Content-Type": "application/json",
      Accept: "application/json"
    }
  }

  let(:params) {
    {
      original_url: "https://example.com"
    }
  }

  let(:invalid_params) {
    {
      original_url: "example.com"
    }
  }
  describe 'POST #create' do
    context 'with authentication' do
      context "with valid params" do
        before { post api_v1_urls_path, params: params.to_json, headers: headers }

        it 'creates a shortened URL' do
          expect(response).to have_http_status(:success)
          body = JSON.parse(response.body)

          expect(body).to have_key('shortened_url')
        end
      end
      context "with invalid params" do
        before { post api_v1_urls_path, params: invalid_params.to_json, headers: headers }

        it 'creates a shortened URL' do
          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)

          expect(body["errors"]).to contain_exactly("Original url is invalid")
        end
      end
    end

    context 'without authentication' do
      before { post api_v1_urls_path, params: params.to_json }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
