class AddArtistToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :artist, :string
  end
end
