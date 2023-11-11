class RedirectionsController < ApplicationController
  def show
    url = Url.find_by(shortened_url: params[:shortened_url])

    if url.nil? || url.expired?
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    else url
      redirect_to url.original_url, allow_other_host: true
    end
  end
end
