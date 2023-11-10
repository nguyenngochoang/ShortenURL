class UrlSerializer < ActiveModel::Serializer
  attributes :id, :formated_shortened_url, :refs

  def formated_shortened_url
    @instance_options[:host] + object.shortened_url
  end

  def refs
    {
      self: @instance_options[:api_link]
    }
  end
end
