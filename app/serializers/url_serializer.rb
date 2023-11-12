class UrlSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  DEFAULT_TIMEZONE = "Asia/Saigon"

  attributes :id, :shortened_url, :refs, :code, :expires_at

  def shortened_url
    shorten_url_redirect_url(shortened_url: object.shortened_url)
  end

  def code
    @instance_options[:code]
  end

  def expires_at
    object
      .expires_at
      .in_time_zone(@instance_options[:timezone] || DEFAULT_TIMEZONE)
      .strftime("%A, %B %e, %Y %I:%M %p")
  end

  def refs
    {
      self: @instance_options[:api_link]
    }
  end
end
