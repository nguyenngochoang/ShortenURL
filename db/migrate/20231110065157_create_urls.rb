class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :original_url
      t.string :shortened_url
      t.datetime :expires_at

      t.timestamps
    end
  end
end
