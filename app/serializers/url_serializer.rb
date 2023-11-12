class UrlSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :shortened_url, :refs, :api_status

  def shortened_url
    shorten_url_redirect_url(shortened_url: object.shortened_url)
  end

  def code
    @instance_options[:code]
  end

  def refs
    {
      self: @instance_options[:api_link]
    }
  end
end
