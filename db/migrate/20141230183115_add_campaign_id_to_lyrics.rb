class AddCampaignIdToLyrics < ActiveRecord::Migration
  def change
    add_column :lyrics, :campaign_id, :integer
  end
end
