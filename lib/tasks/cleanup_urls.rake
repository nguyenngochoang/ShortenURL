namespace :urls do
  desc "Cleanup expired urls"
  task cleanup: :environment do
    Url.expired.destroy_all
  end
end
