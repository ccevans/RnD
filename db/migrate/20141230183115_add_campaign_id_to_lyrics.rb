class AddCampaignIdToLyrics < ActiveRecord::Migration
  def change
    add_column :lyrics, :campaign_id, :integer, :default => "2"
  end
end
