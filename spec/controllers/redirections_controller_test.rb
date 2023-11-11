# spec/controllers/redirections_controller_spec.rb

require 'rails_helper'

RSpec.describe RedirectionsController, type: :controller do
  describe 'GET #show' do
    context 'when the URL is found and not expired' do
      let(:url) { create(:url, expires_at: Time.now + 1.day) }

      it 'redirects to the original URL' do
        get :show, params: { shortened_url: url.shortened_url }

        expect(response).to redirect_to(url.original_url)
      end
    end

    context 'when the URL is found but expired' do
      let(:expired_url) { create(:url, expires_at: Time.now - 1.day) }

      it 'renders a 404 page' do
        get :show, params: { shortened_url: expired_url.shortened_url }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("The page you were looking for doesn't exist")
      end
    end

    context 'when the URL is not found' do
      it 'renders a 404 page' do
        get :show, params: { shortened_url: 'non_existent_url' }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("The page you were looking for doesn't exist")
      end
    end
  end
end
